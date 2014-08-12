--[[
	角色类
]]
local scheduler = require(cc.PACKAGE_NAME..".scheduler")

local Player = class("Player", cc.mvc.ModelBase)

--素材
Player.resources = {"Zombie_polevaulter","Zombie_ladder","Zombie_jackbox","Zombie_imp","Zombie_gargantuar","Zombie_dolphinrider","Zombie_balloon"}
--行为
Player.behaviors = {"anim_walk","anim_eat","anim_placeladder","anim_idle","anim_ladderwalk","anim_laddereat","anim_death"}
--Action对应的tag
Player.actTags = {anim_idle=100,anim_walk=101,anim_eat=102,anim_eat=103,anim_death=104, celabrate=105,relive=106,attacked=107}

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
Player.schema["hp"]	= {"number",1}
Player.schema["target"] = {"string"}
Player.schema["res"] = {"string",Player.resources[math.random(1,#Player.resources)]}
Player.schema["direction"] = {"number",1}--朝向
Player.schema["x"] = {"number",1}--朝向
Player.schema["y"] = {"number",1}--朝向

function Player:ctor(properties, events, callbacks)
	Player.super.ctor(self,properties)
	self:addComponent("components.behavior.StateMachine")
	self.fsm__ = self:getComponent("components.behavior.StateMachine")
	local defaultEvents = {
		{name="start", from="none", to="idle"},
		{name="fire", from="idle", to="firing"},
		{name="ready", from="firing", to="idle"},
		{name="walk",from="idle",to="walking"},
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
		onleavefiring = handler(self, self.onLeaveFiring_),
		onwalk = handler(self, self.onWalking),
	}

	table.merge(defaultCallbacks, checktable(callbacks))
	self.fsm__:setupState({
		events = defaultEvents,
		callbacks = defaultCallbacks
	})

	self.fsm__:doEvent("start")
end

--警戒范围，这些应该是从静态数据读取的
function Player:getRadius()
	return 50
end

--资源
function Player:getRes()
	return self.res_
end

function Player:getX()
	return self.x_
end

function Player:getY()
	return self.y_
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
--行为对象 
function Player:getTarget()
    return self.target_
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

function Player:getDirection()
	return self.direction_
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
		damage = self:getAttack() - armor
		if damage <= 0 then 
			damage = 1 
		end
		self:dispatchEvent({name = Player.UNDER_ATTACK_EVENT,source=self,damage=damage})
	end
	return damage
end

function Player:onChangeState_(event)
	printf("Player %s:%s state changed from %s to %s",self:getId(), self.nickname_,event.from,event.to)
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

function Player:onWalking(event)
	local target = self.target_
	if target_ ~= nil then

	end
end

function Player:searchTarget()
	local target
	if self.target_ ~= nil then
		target = app:getObject(self.target_)
		if target:isDead() then
			self.target_ = nil
		end
	end

	if self.target_ == nil then
		local temptarget = app:getTarget(self)
		if temptarget ~= nil then--有敌人
			self.target_ = temptarget
		end
	end
end
--取得技能
function Player:getSkills( )
	-- body
end

return Player