local scheduler = require(cc.PACKAGE_NAME..".scheduler")
--[[
	角色类
]]
local Player = class("Player", cc.mvc.ModelBase)

Player.actTags = {"idle"=100,"walk"=101,"attack"=102,"spell"=103,"dead"=104, "celabrate"=105,"relive"=106,"attacked"=107}--Action对应的tag

Player.CHANGE_STATE_EVENT = "CHANGE_STATE_EVENT"	--状态改变事件

--定义属性
Player.schema = clone(cc.mvc.ModelBase.schema)
Player.schema["nickname"]	= 	["string"]
Player.shcema["level"]	=	["number",1]
Player.schema["hp"]	=["int",1]
Player.schema["mp"] = ["int",1]
Player.schema["rawid"]=["int",0]--id对应静态数据，可以拿出所有数据

function Player:ctor(properties, events, callbacks)
	Player.super.ctor(self,properties)
	self:addComponent("cc.components.behavior.StateMachine")
	self.fsm__ = self:getComponent("cc.components.behavior.StateMachine")
	local defaultEvents = {
		{name="start", from="none", to="idle"},
		{name="attack", from="idle", to="attack"},
		{name="ready", from="attack", to="idle"},
		{name="kill", from={"idle","attack"}, to="idle"},
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

	table.table.merge(defaultCallbacks, checktable(callbacks))
end

function Player:getNickName()
	return delf.nickname_
end

function Player:getLevel()
	return self.level_
end

function Player:getHp()
	return self.hp_
end

function Player:isDead( )
	return self.fsm__:getState() == "dead"
end

function Player:getState()
	return self.fsm__:getState()
end


function Player:addHp(hp)
	assert(not self:isDead(), string.format("actor %s:%s is dead, can't change Hp", self:getId(), self:getNickName()))
	assert(hp > 0, string.format("Actor:addHp(hp) - invalid hp value: %s", hp)