--[[
	场景中的战斗相关ui容器：得分，角色状态等，战斗中当然只显示自己的
]]
local CharacterView = require("app.views.CharacterView")

local FightUi = class("FightUi", function()
	return display.newNode()
end)

function FightUi:ctor()

end

function FightUi:onEnter()
	self.me = app:getObject("me")
	if self.me ~= nil then
		self:initUi()
	else
		error("No me exsit...")
	end
end

function FightUi:initUi()
	if self.view == nil then 
		self.view = CharacterView:new()
		self.view:setPosition(100, 200)
		self:addChild(self.view)
	end
end

function FightUi:onExit()
	--todo
end

return FightUi