--[[
	鎴樻枟鍦烘櫙
]]
local Player = require("app.models.Player")
local Hero = require("app.models.Hero")
local AnotherScene = class("AnotherScene", function()
    return display.newScene("AnotherScene")
end)

local scheduler = require("framework.scheduler")

function AnotherScene:ctor()
	self.speed = 100;
	self.curBehaviorId = 1;
    self.layer = display.newLayer()
    self:addChild(self.layer)
    self.layer:setTouchEnabled(true)
    self.bg = display.newSprite("battle.png",display.cx, display.cy)
    self.bg1 = display.newSprite("battle.png",display.cx+self.bg:getContentSize().width, display.cy)
    self.layer:addChild(self.bg)
    self.layer:addChild(self.bg1)
    self.players = {}
end

--娣诲姞涓�釜鐜╁鍒拌垶鍙颁笂#AnotherScene:addPlayer
function AnotherScene:addPlayer(playerId)
	local player = self,players[playerId]
	if player ~= nil then
		local res = player:getRes()
	end
end


function AnotherScene:onTouch(event)
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

function AnotherScene:onEnterFrame(dt)
	--[[for i,v in pairs(self.players) do
		if v:getActionByTag(100) == nil and self.state ~= "idle" then
			v.animation:play("anim_idle")
		end
	end

	if self.zombie:getActionByTag(100) == nil and self.state ~= "idle" then
		self.animation:play("anim_idle")
		self.state = "idle"
	end]]
end

function AnotherScene:onEnter()
	local manager = CCArmatureDataManager:sharedArmatureDataManager()
    manager:addArmatureFileInfo("Zombie.png","Zombie.plist","Zombie.xml")
    local attacker = app:getObject("me")
    local defender = app:getObject("enemy")
    --[[
    self.zombie = CCArmature:create("Zombie_gargantuar")
    self.animation = self.zombie:getAnimation()
    self.animation:setSpeedScale(0.2)
    self.animation:play("anim_idle")
    self.state = "idle"
    self.zombie:setPosition(display.cx, display.cy)
    self.zombie:setScaleX(-1)
    self.layer:addChild(self.zombie)
    ]]
    self.layer:addNodeEventListener(cc.NODE_TOUCH_EVENT, function( event )
    	-- body
    	self.onTouch(event)
    end)
    self.layer:setTouchEnabled(true)
    self:schedule(self.onEnterFrame,1)
end

return AnotherScene