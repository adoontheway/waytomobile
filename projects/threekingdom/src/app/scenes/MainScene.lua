
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

local JoyStick = import("app.tools.JoyStick")
local scheduler = import("framework.scheduler")
function MainScene:ctor()
    display.newSprite("bg.jpg")
    	:pos(display.cx, display.cy)
    	:addTo(self)
end

function MainScene:onEnter()
	display.addSpriteFrames("hero/zhuge.plist","hero/zhuge.png")
	self.player = display.newSprite()
	self.player.speed = 20
	self:addChild(self.player)
	self.player:pos(display.cx, display.cy)
	self.animAction = self:playAnimation(self.player, "standby", 0, 48, false)
	self:setTouchEnabled(true)
	
	self.sticker = JoyStick.new("ui/bgm.png","ui/bgs.png","ui/touchres.png")
	self.sticker:pos(80,80)
	self.sticker:control(self.player,handler(self,self.onStateChange))
	local atkBtn = display.newSprite("ui/btn.png")
	atkBtn:pos(200, 80)
	self.atkBtn = atkBtn
	self.atkBtn:setTouchEnabled(true)
	self:addChild(self.sticker)
	self:addChild(atkBtn)
	self.atkBtn:addNodeEventListener(cc.NODE_TOUCH_EVENT, function( event )
		self:onTouched(event)
	end)

	self.tickhandler = scheduler.scheduleGlobal(handler(self, self.onTick), 1/60)
end

function MainScene:onTouched( event )
	self.animAction = self:playAnimation(self.player, "attack", 0, 9, true)
end

function MainScene:playAnimation(player, framename, startindex, endindex, once)
	self.player.state = framename
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

function MainScene:onStateChange()
	local tstate = self.sticker:isFullEng() and "run" or "walk"
	local tdirection = self.sticker:getDirection()
	if tdirection ~= self.player:getScaleX() then
		self.player:setScaleX(tdirection)
	end
	if self.player.state ~= tstate then
		if tstate == "run" then
			self:playAnimation(self.player, tstate, 0, 7, false)
		else
			self:playAnimation(self.player, tstate, 0, 25, false)
		end
	end
	
end

function MainScene:onTick( dt )
	
end

function MainScene:onExit()
end

return MainScene
