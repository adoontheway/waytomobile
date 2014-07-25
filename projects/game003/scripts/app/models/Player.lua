--[[
	角色类
]]
local scheduler = require(cc.PACKAGE_NAME..".scheduler")

local Player = class("Player", cc.mvc.ModelBase)
--[[
--素材
Player.resources = {"Zombie_polevaulter","Zombie_ladder","Zombie_jackbox","Zombie_imp","Zombie_gargantuar","Zombie_dolphinrider","Zombie_balloon"}
--行为
Player.behaviors = {"anim_walk","anim_eat","anim_placeladder","anim_idle","anim_ladderwalk","anim_laddereat","anim_death"}
--Action对应的tag
Player.actTags = {anim_idle=100,anim_walk=101,anim_eat=102,anim_eat=103,anim_death=104, celabrate=105,relive=106,attacked=107}
]]
Player.CHANGE_STATE_EVENT = "CHANGE_STATE_EVENT"	--状态改变事件#CHANGE_STATE_EVENT
Player.ATTACK_EVENT = "ATTACK_EVENT"
Player.UNDER_ATTACK_EVENT = "UNDER_ATTACK_EVENT"
Player.START_EVENT = "START_EVENT"
Player.READY_EVENT = "READY_EVENT"
Player.FIRE_EVENT = "FIRE_EVENT"
Player.THAW_EVENT = "THAW_EVENT"
Player.KILL_EVENT = "KILL_EVENT"
Player.RELIVE_EVENT = "RELIVE_EVENT"
Player.HP_CHANGED_EVENT = "HP_CHANGED_EVENT"--血量改变
Player.FREEZE_EVENT = "FREEZE_EVENT"

--定义属性
Player.schema = clone(cc.mvc.ModelBase.schema)
Player.schema["nickname"]	= 	{"string"}
Player.schema["level"]	=	{"number",1}
Player.schema["hp"]	={"number",1}
--Player.schema["res"] = {"string",Player.resources[math.random(1,#Player.resources)]}

function Player:ctor(properties, events, callbacks)
	Player.super.ctor(self,properties)
	self:addComponent("components.behavior.StateMachine")
	self.fsm__ = self:getComponent("components.behavior.StateMachine")
	
	local defaultEvents = {
		{name="start", from="none", to="idle"},
		{name="fire", from="idle", to="firing"},
		{name="ready", from="firing", to="idle"},
		{name="freeeze", from="idle", to="frozen"},
		{name="thaw", from="frozen", to="idle"},
		{name="kill", from={"idle","frozen"}, to="dead"},
		{name="relive", from="dead", to="idle"}
	}
	table.insertto(defaultEvents,checktable(events))

	local defaultCallbacks ={
		onchangestate = handler(self, self.onChangeState_),
		onstart = handler(self, self.onStart_),
		onfire = handler(self, self.onFire_),
		onready = handler(self, self.onReady_),
		onfreeze = handler(self, self.onFrozen_),
		onthaw = handler(self, self.onThaw_),
		onkill = handler(self, self.onKill_),
		onrelive = handler(self, self.onRelive_),
		onleavefiring = handler(self, self.onLeaveFiring_)
	}

	table.merge(defaultCallbacks, checktable(callbacks))
	self.fsm__:setupState({
		events = defaultEvents,
		callbacks = defaultCallbacks
		})
	
	self.fsm__:doEvent("start")
end
--资源
function Player:getRes()
	return self.res_
end

function Player:getNickName()
	return self.nickname_
end

function Player:getLevel()
	return self.level_
end

function Player:getHp()
	return self.hp_
end

function Player:getMaxHp()
	return self.level_ * 100
end

function Player:isDead( )
	return self.fsm__:getState() == "dead"
end

function Player:canFire()
	return self.fsm__:canDoEvent("fire")
end

function Player:getAttack( )
	return self.level_ * 5
end

function Player:getArmor()
	return self.level_ * 2
end

function Player:isFrozen()
	return self.fsm__:getState() == "frozen"
end

function Player:getState()
	return self.fsm__:getState()
end

function Player:getCoolDown()
	return 2
end

function Player:setFullHp()
	self.hp = self:getMaxHp()
end

function Player:canFire()
    return self.fsm__:canDoEvent("fire")
end

function Player:increaseHp(hp)
	assert(not self:isDead(), string.format("Player %s:%s is dead, can't change Hp", self:getId(), self:getNickName()))
	assert(hp > 0, string.format("Player:increaseHp(hp) - invalid hp value: %s", hp))
	local newhp = self.hp_ + hp
	if newhp > self:getMaxHp() then
		newhp = self:getMaxHp()
	end

	if newhp > self.hp_ then
		self:dispatchEvent({name = Player.HP_CHANGED_EVENT})
	end

	return self
end

function Player:decreaseHp(hp)
	assert(not self:isDead(), string.format("Player %s:%s is dead, can't change Hp", self:getId(), self:getNickName()))
	assert(hp > 0, string.format("Player:decreaseHp(hp) - invalid hp value: %s", hp))
	local newhp = self.hp_ - hp
	if newhp <= 0 then
		newhp = 0
	end

	if newhp < self.hp_ then
		self.hp_ = newhp
		self:dispatchEvent({name = Player.HP_CHANGED_EVENT})
		if newhp == 0 then
			self.fsm__:doEvent("kill")
		end
	end
	return self
end

function Player:fire(enemy)
	self.fsm__:doEvent("fire")
	self.fsm__:doEvent("ready",self:getCoolDown())
end

function Player:hit(enemy)
	assert(not self:isDead(), string.format("Player %s:%s is dead, can't fire", self:getId(), self:getNickName()))

	local damage = 0
	if math.random(1,100) <= 80 then
		local armor = 0
		if not enemy:isFrozen() then
			armor = enemy:getArmor()
		end
		damage = self:geAttack() - armor
		if damage <= 0 then 
			damage = 1 
		end
		self:dispatchEvent({name = Player.UNDER_ATTACK_EVENT,source=self,damage=damage})
	end
	return damage
end

function Player:onChangeState_(event)
	printf("Player %s:%s state changed from %s to %s",self:getId(), self.nickname_,event.from,event.to)
	print("What is wrong fucking with you")
	event = {name=Player.CHANGE_STATE_EVENT,from=event.from, to=event.to}
	self:dispatchEvent(event)
end

function Player:onStart_( event )
	printf("Player %s:%s started..", self:getId(),self.nickname_)
	self:setFullHp();
	self:dispatchEvent({name=Player.START_EVENT})
end

function Player:onReady_(event)
	printf("Player %s:%s fire", self:getId(), self.nickname_)
	self:dispatchEvent({name = Player.FIRE_EVENT})
end

function Player:onThaw_(event)
	printf("Player %s:%s thawing", self:getId(), self.nickname_)
	self:dispatchEvent({name = Player.THAW_EVENT})
end

function Player:onFire_(event)
	printf("Player %s:%s is firing", self:getId(), self.nickname_)
	self:dispatchEvent({name = Player.FIRE_EVENT})
end

function Player:onFreeze_(event)
	printf("Player %s:%s is frozen", self:getId(), self:getNickName())
	self:dispatchEvent({name = Player.FREEZE_EVENT})
end

function Player:onKill_(event)
	printf("Player %s:%s is killed", self:getId(), self.nickname_)
	self:dispatchEvent({name = Player.KILL_EVENT})
end

function Player:onRelive_(event)
	printf("Player %s:%s is relived", self:getId(), self.nickname_)
	self:dispatchEvent({name = Player.RELIVE_EVENT})
end

function Player:onLeavingFiring_(event)
	local coolDown = checknumber(event.args[1])
	if coolDown > 0 then
		scheduler.performWithDelayGlobal(function()
			event.transition()
		end, coolDown)
		return "async"
	end
end

return Player

--[[
local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")

local Player = class("Player", cc.mvc.ModelBase)

-- 常量
Player.FIRE_COOLDOWN = 0.2 -- 开火冷却时间

-- 定义事件
Player.CHANGE_STATE_EVENT = "CHANGE_STATE_EVENT"
Player.START_EVENT         = "START_EVENT"
Player.READY_EVENT         = "READY_EVENT"
Player.FIRE_EVENT          = "FIRE_EVENT"
Player.FREEZE_EVENT        = "FREEZE_EVENT"
Player.THAW_EVENT          = "THAW_EVENT"
Player.KILL_EVENT          = "KILL_EVENT"
Player.RELIVE_EVENT        = "RELIVE_EVENT"
Player.HP_CHANGED_EVENT    = "HP_CHANGED_EVENT"
Player.ATTACK_EVENT        = "ATTACK_EVENT"
Player.UNDER_ATTACK_EVENT  = "UNDER_ATTACK_EVENT"

-- 定义属性
Player.schema = clone(cc.mvc.ModelBase.schema)
Player.schema["nickname"] = {"string"} -- 字符串类型，没有默认值
Player.schema["level"]    = {"number", 1} -- 数值类型，默认值 1
Player.schema["hp"]       = {"number", 1}

function Player:ctor(properties, events, callbacks)
    Player.super.ctor(self, properties)

    -- 因为角色存在不同状态，所以这里为 Player 绑定了状态机组件
    self:addComponent("components.behavior.StateMachine")
    -- 由于状态机仅供内部使用，所以不应该调用组件的 exportMethods() 方法，改为用内部属性保存状态机组件对象
    self.fsm__ = self:getComponent("components.behavior.StateMachine")

    -- 设定状态机的默认事件
    local defaultEvents = {
        -- 初始化后，角色处于 idle 状态
        {name = "start",  from = "none",    to = "idle" },
        -- 开火
        {name = "fire",   from = "idle",    to = "firing"},
        -- 开火冷却结束
        {name = "ready",  from = "firing",  to = "idle"},
        -- 角色被冰冻
        {name = "freeze", from = "idle",    to = "frozen"},
        -- 从冰冻状态恢复
        {name = "thaw",   form = "frozen",  to = "idle"},
        -- 角色在正常状态和冰冻状态下都可能被杀死
        {name = "kill",   from = {"idle", "frozen"}, to = "dead"},
        -- 复活
        {name = "relive", from = "dead",    to = "idle"},
    }
    -- 如果继承类提供了其他事件，则合并
    table.insertto(defaultEvents, checktable(events))

    -- 设定状态机的默认回调
    local defaultCallbacks = {
        onchangestate = handler(self, self.onChangeState_),
        onstart       = handler(self, self.onStart_),
        onfire        = handler(self, self.onFire_),
        onready       = handler(self, self.onReady_),
        onfreeze      = handler(self, self.onFreeze_),
        onthaw        = handler(self, self.onThaw_),
        onkill        = handler(self, self.onKill_),
        onrelive      = handler(self, self.onRelive_),
        onleavefiring = handler(self, self.onLeaveFiring_),
    }
    -- 如果继承类提供了其他回调，则合并
    table.merge(defaultCallbacks, checktable(callbacks))

    self.fsm__:setupState({
        events = defaultEvents,
        callbacks = defaultCallbacks
    })

    self.fsm__:doEvent("start") -- 启动状态机
end

function Player:getNickname()
    return self.nickname_
end

function Player:getLevel()
    return self.level_
end

function Player:getHp()
    return self.hp_
end

function Player:getMaxHp()
    -- 简化算法：最大 Hp = 等级 x 100
    return self.level_ * 100
end

function Player:getAttack()
    -- 简化算法：攻击力是等级 x 5
    return self.level_ * 5
end

function Player:getArmor()
    -- 简化算法：防御是等级 x 2
    return self.level_ * 2
end

function Player:getState()
    return self.fsm__:getState()
end

function Player:canFire()
    return self.fsm__:canDoEvent("fire")
end

function Player:isDead()
    return self.fsm__:getState() == "dead"
end

function Player:isFrozen()
    return self.fsm__:getState() == "frozen"
end

function Player:setFullHp()
    self.hp_ = self:getMaxHp()
    return sef
end

function Player:increaseHp(hp)
    assert(not self:isDead(), string.format("Player %s:%s is dead, can't change Hp", self:getId(), self:getNickname()))
    assert(hp > 0, "Player:increaseHp() - invalid hp")

    local newhp = self.hp_ + hp
    if newhp > self:getMaxHp() then
        newhp = self:getMaxHp()
    end

    if newhp > self.hp_ then
        self.hp_ = newhp
        self:dispatchEvent({name = Player.HP_CHANGED_EVENT})
    end

    return self
end

function Player:decreaseHp(hp)
    assert(not self:isDead(), string.format("Player %s:%s is dead, can't change Hp", self:getId(), self:getNickname()))
    assert(hp > 0, "Player:increaseHp() - invalid hp")

    local newhp = self.hp_ - hp
    if newhp <= 0 then
        newhp = 0
    end

    if newhp < self.hp_ then
        self.hp_ = newhp
        self:dispatchEvent({name = Player.HP_CHANGED_EVENT})
        if newhp == 0 then
            self.fsm__:doEvent("kill")
        end
    end

    return self
end

-- 开火
function Player:fire()
    print("----------")
    self.fsm__:doEvent("fire")
    self.fsm__:doEvent("ready", Player.FIRE_COOLDOWN)
end

-- 命中目标
function Player:hit(enemy)
    assert(not self:isDead(), string.format("Player %s:%s is dead, can't change Hp", self:getId(), self:getNickname()))

    -- 简化算法：伤害 = 自己的攻击力 - 目标防御
    local damage = 0
    if math.random(1, 100) <= 80 then -- 命中率 80%
        local armor = 0
        if not enemy:isFrozen() then -- 如果目标被冰冻，则无视防御
            armor = enemy:getArmor()
        end
        damage = self:getAttack() - armor
        if damage <= 0 then damage = 1 end -- 只要命中，强制扣 HP
    end
    -- 触发事件，damage <= 0 可以视为 miss
    self:dispatchEvent({name = Player.ATTACK_EVENT, enemy = enemy, damage = damage})
    if damage > 0 then
        -- 扣除目标 HP，并触发事件
        enemy:decreaseHp(damage) -- 扣除目标 Hp
        enemy:dispatchEvent({name = Player.UNDER_ATTACK_EVENT, source = self, damage = damage})
    end

    return damage
end

---- state callbacks

function Player:onChangeState_(event)
    printf("Player %s:%s state change from %s to %s", self:getId(), self.nickname_, event.from, event.to)
    event = {name = Player.CHANGE_STATE_EVENT, from = event.from, to = event.to}
    self:dispatchEvent(event)
end

-- 启动状态机时，设定角色默认 Hp
function Player:onStart_(event)
    printf("Player %s:%s start", self:getId(), self.nickname_)
    self:setFullHp()
    self:dispatchEvent({name = Player.START_EVENT})
end

function Player:onReady_(event)
    printf("Player %s:%s ready", self:getId(), self.nickname_)
    self:dispatchEvent({name = Player.READY_EVENT})
end

function Player:onFire_(event)
    printf("Player %s:%s fire", self:getId(), self.nickname_)
    self:dispatchEvent({name = Player.FIRE_EVENT})
end

function Player:onFreeze_(event)
    printf("Player %s:%s frozen", self:getId(), self.nickname_)
    self:dispatchEvent({name = Player.FREEZE_EVENT})
end

function Player:onThaw_(event)
    printf("Player %s:%s thawing", self:getId(), self.nickname_)
    self:dispatchEvent({name = Player.THAW_EVENT})
end

function Player:onKill_(event)
    printf("Player %s:%s dead", self:getId(), self.nickname_)
    self.hp_ = 0
    self:dispatchEvent({name = Player.KILL_EVENT})
end

function Player:onRelive_(event)
    printf("Player %s:%s relive", self:getId(), self.nickname_)
    self:setFullHp()
    self:dispatchEvent({name = Player.RELIVE_EVENT})
end

function Player:onLeaveFiring_(event)
    local cooldown = checknumber(event.args[1])
    if cooldown > 0 then
        -- 如果开火后的冷却时间大于 0，则需要等待
        scheduler.performWithDelayGlobal(function()
            event.transition()
        end, cooldown)
        return "async"
    end
end

return Player
]]