local AnotherScene = class("AnotherScene", function()
    return display.newScene("AnotherScene")
end)

function AnotherScene:ctor()
	self.curBehaviorId = 1;
    self.layer = display.newLayer()
    self:addChild(self.layer)
    self.layer:setTouchEnabled(true)
    self.behaviors = {"anim_walk","anim_eat","anim_placeladder","anim_idle","anim_ladderwalk","anim_laddereat","anim_death"};
end

function AnotherScene:onTouch(event, x, y)
	print("Touched at %d %d",x,y)
	self.curBehaviorId = self.curBehaviorId + 1;
	if self.curBehaviorId > #self.behaviors then
		self.curBehaviorId = 1;
	end
	print("Now playing ", self.curBehaviorId , #self.behaviors, self.behaviors[self.curBehaviorId])
	self.animation:play(self.behaviors[self.curBehaviorId])
end

function AnotherScene:onEnter()
    self.bg = display.newSprite("battle.png",display.cx, display.cy)
    self.layer:addChild(self.bg)
    ui.newTTFLabel({text = "AnotherScene", size = 64, align = ui.TEXT_ALIGN_CENTER})
        :pos(display.cx, display.cy)
        :addTo(self.layer)

    local manager = CCArmatureDataManager:sharedArmatureDataManager()
    manager:addArmatureFileInfo("Zombie.png","Zombie.plist","Zombie.xml")
    local zombie = CCNodeExtend.extend(CCArmature:create("Zombie_ladder"))
    zombie:connectMovementEventSignal(function(__evtType, __moveId)
			echoInfo("movement, evtType: %d, moveId: %s", __evtType, __moveId)
		end)
    self.animation = zombie:getAnimation()
    self.animation:setAnimationScale(0.5)
    self.animation:play("anim_walk")
    zombie:setPosition(display.cx, display.cy)
    self.layer:addChild(zombie)
    self.layer:addTouchEventListener(function(event,x,y)
    	return self:onTouch(event, x,y)
    	end)	
    self.layer:setTouchEnabled(true)
end
return AnotherScene