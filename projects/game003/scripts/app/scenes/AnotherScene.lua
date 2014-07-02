local AnotherScene = class("AnotherScene", function()
    return display.newScene("AnotherScene")
end)

function AnotherScene:ctor()
    self.layer = display.newLayer()
    self:addChild(self.layer)
    self.layer:setTouchEnabled(true)
end

function AnotherScene:onTouch(event, x, y)

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
    local animation = zombie:getAnimation()
    animation:setAnimationScale(0.5)
    animation:play("anim_walk")
    zombie:setPosition(display.cx, display.cy)
    self.layer:addChild(zombie)
    self.layer:addTouchEventListener(function(event,x,y)
    	return self:onTouch(event, x,y)
    	end)	
    self.layer:setTouchEnabled(true)
end
return AnotherScene