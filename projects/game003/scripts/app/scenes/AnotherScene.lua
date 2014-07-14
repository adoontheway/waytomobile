local AnotherScene = class("AnotherScene", function()
    return display.newScene("AnotherScene")
end)

local scheduler = require("framework.scheduler")

function AnotherScene:ctor()
	self.speed = 2;
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

	--[[if self.tempAction ~= nill then
		
	end]]
	if x < self.zombie:getPositionX() then
		self.zombie:setScaleX(1)
	else
		self.zombie:setScaleX(-1)
	end

	local action = CCMoveTo:create(math.random(1,5), CCPoint(x,y))
	self.zombie:runAction(action)
	self.tempAction = action;
	self.animation:play("anim_walk")
	--[[
	local len1 = #self.zombies;
	local len2 = #self.behaviors;
	for i=1,10 do
		print(self.zombies[i],self.behaviors[i])
		local sp = CCArmature:create(self.zombies[i])
		local animation = sp:getAnimation()
		if animation ~= nil then
			animation:play(self.behaviors[1])--ÓÐµÄ¶¯×÷Õâ¸öÃ»ÓÐ
			animation:setSpeedScale(0.5)
			sp:setPosition(math.random(display.left, display.right), math.random(display.bottom, display.top))
			self.layer:addChild(sp)
		end
	end

	self.curBehaviorId = self.curBehaviorId + 1;
	if self.curBehaviorId > #self.behaviors then
		self.curBehaviorId = 1;
	end
	self.animation:play(self.behaviors[self.curBehaviorId])
	]]
end

function AnotherScene:onEnterFrame(dt)
	--[[
	local tempX = self.bg:getPositionX();
	local tempW = self.bg:getContentSize().width;
	tempX = tempX - self.speed;
	if tempX <= display.cx - tempW then
		self.bg:setPositionX(display.cx + tempW)
	else
		self.bg:setPositionX(tempX)
	end

	tempX = self.bg1:getPositionX();
	tempW = self.bg1:getContentSize().width;
	tempX = tempX - self.speed;
	if tempX <= display.cx - tempW then
		self.bg1:setPositionX(display.cx + tempW)
	else
		self.bg1:setPositionX(tempX)
	end]]
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