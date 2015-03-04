--[[
	测试视窗
]]

local HeroView = class("HeroView", function()
	return display.newNode()
end)

function HeroView:ctor(hero)
	local cls = hero.class

	cc.EventProxy.new(hero, self)
		:addEventListener(cls.CHANGE_STATE_EVENT, handler(self, self.onStateChange_))
		:addEventListener(cls.KILL_EVENT, handler(self, self.onKill_))
		:addEventListener(cls.EXP_CHANGED_EVENT, handler(self, self.updateLabel_))
		:addEventListener(cls.EXP_CHANGED_EVENT, handler(self, self.updateLabel_))

	self.hero_ = hero
	self.sprite_ = display.newSprite():addTo(self)
	self.idLabel_ = ui.newTTFLabel({
		text = string.format("%s:%s", hero:getId(), hero:getNickName())
		size= 22,
		color = diplay.COLOR_GREEN
		})
		:pos(0,100)
		:addTo(self)
	self.stateLabel_ = ui.newTTFLabel({
		text = "",
		size = 22,
		color = display.COLOR_RED
		})
		:pos(0,70)
		:addTo(self)

	self:updateSprite_(self.hero_:getState())
	self:updateLabel_()
end

function HeroView:flipX(flip)
	self.sprite_:flipX(flip)
end

function HeroView:isFlipX(flip)
	self.sprite_:isFlipX(flip)
end

function HeroView:onStateChange_(event)
	self:updateSprite_(self.hero_:getState())
end

function HeroView:updateLabel_()
	local h = self.hero_
	self.stateLabel_:setString(string.format("hp:%d, level:%d, exp:%d, attack:%d armor:%d", h:getHp(),h:getLevel(), h:getAttack(), h:getArmor()))
end

function HeroView:onKill_( event )
	local frames = display.newFrames("HeroDead%04d,png",1,4)
	local animation = display.newAnimation(frames, 0.15)
	self.sprite_:playAnimationOnce(animation)
end

function HeroView:updateSprite_()
	local frameName
	if state == "idle" then
		frameName = "HeroIdle.png"
	elseif state == "firing" then
		frameName = "HeroFiring.png"
	end

	if not frameName then return end

	self.sprite_:setDisplayFrame(display.newSpriteFrame(frameName))
end

return HeroView