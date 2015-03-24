
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)
local JoyStick = import("app.tools.JoyStick")
function MainScene:ctor()
    display.newSprite("bg.jpg")
    	:pos(display.cx, display.cy)
    	:addTo(self)
end

function MainScene:onEnter()
	display.addSpriteFrames("hero/zhuge.plist","hero/zhuge.png")
	self.player = display.newSprite()
	self:addChild(self.player)
	self.player:pos(display.cx, display.cy)
	self.animAction = self:playAnimation(self.player, "standby", 0, 48, false)
	self:setTouchEnabled(true)
	self:addNodeEventListener(cc.NODE_TOUCH_EVENT, function( event )
		self:onTouched(event)
	end)
	local sticker = JoyStick.new("ui/sbg.png","ui/touchres.png","ui/arrow.png")
	sticker:pos(80,80)
	self:addChild(sticker)
end

function MainScene:onTouched( event )
	self.animAction = self:playAnimation(self.player, "attack", 0, 9, true)
end

function MainScene:playAnimation(player, framename, startindex, endindex, once)
	local animationname = player:getName()..framename
	local animation = display.getAnimationCache(animationname)
	if animation == nil then
		local frames = display.newFrames(framename.."%04d",startindex, endindex)
		animation = display.newAnimation(frames,1/24)
		display.setAnimationCache(animationname,animation)
	end
	if self.animAction ~= nil then
		transition.removeAction(self.animAction)
		self.animAction = nil
	end
	local function onPlayCompleted( )
		self.animAction = self:playAnimation(self.player, "standby", 0, 48, false)
	end
	if once == true then
		return player:playAnimationOnce(animation,false,onPlayCompleted,0)
	else
		return player:playAnimationForever(animation,0)
	end
end

function MainScene:onExit()
end

return MainScene
