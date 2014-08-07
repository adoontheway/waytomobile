--[[
	鎴樻枟鍦烘櫙
]]
local Player = require("app.models.Player")
local Hero = require("app.models.Hero")
local FightUi = require("app.views.FightUi")

local FightScene = class("FightScene", function()
    return display.newScene("FightScene")
end)

local scheduler = require("framework.scheduler")

function FightScene:ctor()
	self.speed = 100;
	self.curBehaviorId = 1;
    self.layer = display.newLayer()
    self:addChild(self.layer)
    self.layer:setTouchEnabled(true)
    self.bg = display.newSprite("battle_bg/bbg_corridor_ruin.jpg",display.cx, display.cy)
    self.layer:addChild(self.bg)
    self.players = {}
    self.ui = FightUi.new()
end

--娣诲姞涓�釜鐜╁鍒拌垶鍙颁笂#FightScene:addPlayer
function FightScene:addPlayer(playerId)
	local player = self,players[playerId]
	if player ~= nil then
		local res = player:getRes()
	end
end


function FightScene:onTouch(event)
--[[
	if self.zombie:getActionByTag(100) ~= nill then
		self.zombie:stopActionByTag(100)
	end

	if x < self.zombie:getPositionX() then
		self.zombie:setScaleX(1)
	else
		self.zombie:setScaleX(-1)
	end
	local tempX = self.zombie:getPositionX()
	local tempY = self.zombie:getPositionY()
	local distance = math.sqrt(tempX*tempX + tempY*tempY)
	local dura = distance/self.speed
	print("Distance: "..distance.." Speed: "..self.speed.." Duration: "..dura)
	local action = CCMoveTo:create(dura, CCPoint(x,y))
	action:setTag(100)
	self.zombie:runAction(action)
	self.animation:play("anim_walk")
	self.state = "walk"
]]
	print("Touched.....")
end

function FightScene:onEnterFrame(dt)

end

function FightScene:onEnter()
    local manager = CCArmatureDataManager:sharedArmatureDataManager()
    manager:addArmatureFileInfo("Zombie.png","Zombie.plist","Zombie.xml")
    local attacker = app:getObject("me")
    local attackerSp = CCArmature:create(attacker:getRes())
    local animation = attackerSp:getAnimation()
    animation:setSpeedScale(0.2)
    animation:play("anim_walk")
    attackerSp:setPosition(attacker:getX(), attacker:getY())
    attackerSp:setScaleX(attacker:getDirection())
    self.layer:addChild(attackerSp)

    local enemy = app:getObject("enemy")
    local attackerSp1 = CCArmature:create(enemy:getRes())
    local animation1 = attackerSp1:getAnimation()
    animation1:setSpeedScale(0.2)
    animation1:play("anim_walk")
    attackerSp1:setPosition(enemy:getX(), enemy:getY())
    attackerSp1:setScaleX(enemy:getDirection())
    self.layer:addChild(attackerSp1)
   
    self.ui:addTo(self.layer)

    self.layer:addNodeEventListener(cc.NODE_TOUCH_EVENT, function( event )
    	self.onTouch(event)
    end)
    self.layer:setTouchEnabled(true)
    self:schedule(self.onEnterFrame,1)

end

return FightScene