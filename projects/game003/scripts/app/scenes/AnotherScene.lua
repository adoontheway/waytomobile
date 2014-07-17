--[[
	战斗场景
]]
local AnotherScene = class("AnotherScene", function()
    return display.newNode("AnotherScene")
end)

local scheduler = require("framework.scheduler")

function AnotherScene:ctor()
	if not app:Registry.isObjectExists("player") then
		--这些数据需要从服务端拿取
		local player = Hero:new({
			id = 1,
			nickname = "me"
			level =1
		})
		app:setObject("player", player)
	end

	self.palyer = app:getObject("player")

	self.speed = 100;
	self.curBehaviorId = 1;
    self.layer = display.newLayer()
    self:addChild(self.layer)
    self.layer:setTouchEnabled(true)
    self.zombies = {"Zombie_polevaulter","Zombie_ladder","Zombie_jackbox","Zombie_imp","Zombie_gargantuar","Zombie_dolphinrider","Zombie_balloon"};
    self.behaviors = {"anim_walk","anim_eat","anim_placeladder","anim_idle","anim_ladderwalk","anim_laddereat","anim_death"};
    self.bg = display.newSprite("battle.png",display.cx, display.cy)
    self.bg1 = display.newSprite("battle.png",display.cx+self.bg:getContentSize().width, display.cy)
    self.layer:addChild(self.bg)
    self.layer:addChild(self.bg1)
end

function AnotherScene:onTouch(event, x, y)

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
end

function AnotherScene:onEnterFrame(dt)
	if self.zombie:getActionByTag(100) == nil and self.state ~= "idle" then
		self.animation:play("anim_idle")
		self.state = "idle"
	end
end

function AnotherScene:onEnter()
    ui.newTTFLabel({text = "Yo! Yo! Check Out!", size = 64, align = ui.TEXT_ALIGN_CENTER})
        :pos(display.cx, display.cy)
        :addTo(self.layer)

    local manager = CCArmatureDataManager:sharedArmatureDataManager()
    manager:addArmatureFileInfo("Zombie.png","Zombie.plist","Zombie.xml")
    self.zombie = CCArmature:create("Zombie_gargantuar")
    self.animation = self.zombie:getAnimation()
    self.animation:setSpeedScale(0.2)
    self.animation:play("anim_idle")
    self.state = "idle"
    self.zombie:setPosition(display.cx, display.cy)
    self.zombie:setScaleX(-1)
    self.layer:addChild(self.zombie)
    self.layer:addTouchEventListener(function(event,x,y)
    	return self:onTouch(event, x,y)
    	end)	
    self.layer:setTouchEnabled(true)
    self:scheduleUpdate(function(dt) 
    	self:onEnterFrame(dt)
    end)
end
return AnotherScene