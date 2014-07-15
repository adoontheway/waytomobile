local Hero = import("..models.Hero")
local HeroView = import("..views.HeroView")

local PlayerController = class("PlayerController", function(  )
	return display.newNode()
end)

function PlayerController:ctor(  )
	if not app:Registry.isObjectExists("player") then
		local player = Hero:new({
			id = "player",
			nickname = "hehe"
			level =1
		})
		app:setObject("player", player)
	end

	self.palyer = app:getObject("player")
	self.enemy = Hero:new({
		id="enemy",
		nickname="enemy1",
		level=1
		})

	self.views_ = {}
	self.bullets_ = {}

	self.views_[self.player] = HeroView.new(self.player)
		:pos(display.cx-300, display.cy)
		:addTo(self)

	self.views_[self.enemy] = HeroView.new(self.enemy)
		:pos(display.cx+300, display.cy)
		:addTo(self)

	cc.ui.UIPushButton.new("baojix_wenzi.png", {scale9 = true}})
		:setButtonSize(43, 24)
		:setButtonLabel(cc.ui.UILabel.new({text="fire"}))
		:onButtonPressed(function( event )
			event.target:setScale(1.1)
		end)
		:onButtonRelease(function(event)
			event.target.scale(1.0)
		end)
		:onButtonClicked(function(event)
			self:fire(self.player,self.enemy)
		end)
		:pos(display.cx - 300, display.bottom +100)
		:addTo(self)

	cc.ui.UIPushButton.new("fangyu_wenzi.png", {scale9 = true}})
		:setButtonSize(43, 24)
		:setButtonLabel(cc.ui.UILabel.new({text="fire"}))
		:onButtonPressed(function( event )
			event.target:setScale(1.1)
		end)
		:onButtonRelease(function(event)
			event.target.scale(1.0)
		end)
		:onButtonClicked(function(event)
			self:fire(self.enemy,self.player)
		end)
		:pos(display.cx + 300, display.bottom +100)
		:addTo(self)

	self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, handler(self, self.tick))
	self:scheduleUpdate_()

	self:addNodeEventListener(cc.NODE_EVENT, function(event)
		if event.name == "exit" then
			self.player:getComponent("components.behavior.EventProtocol"):dumpAllEventListeners();
		end
	end)
end

function PlayerController:fire(attacker, target)
	if not attacker:canFire() then return end

	attacker:fire()

	local bullet = display.display.newSprite("gongji_wenzi.png"):addTo(self)
	local view = self.views_[attacker]
	local x,y = view:getPosition()
	y = y +12
	if view:isFlipX() then
		x = x - 44
	else
		x = x + 44
	end
	bullet.speed = 5
	bullet:pos(x, y)
	bullet.attacker = attacker
	bullet.target = target
	self.bullets_[#self.bullets_ +1 ] = bullet
end

function PlayerController:hit(attacker, target, bullet)
	if not target:isDead() then
		local damage = attacker:hit(target)
		if damage <= 0 then
			local miss = display.newSprite("shanbix_wenzi.png")
				:pos(bullet:getPosition())
				:addTo(self, 1000)
			transition.moveBy(miss,{y=100, time = 1.5, onComplete=function()
				miss:removeSelf()
			end})
		end
		return damage > 0
	else
		return false
	end
end

function PlayerController:tick(dt)
	for index = #self.bullets_, 1, -1 do
		local bullet = self.bullets_[index]
		local x, y = bullet:getPosition()
		x = x+bullet.speed
		bullet:setPositionX(x)

		if x < display.left - 100 or x > display.right + 100 then
			bullet:removeSelf()
			table.remove(self.bullets_, index)
		elseif
			local targetView = self.views_[bullet.target]
			local tx,ty = targetView:getPosition()
			if dist(x,y,tx,ty) <= 30 then
				if self:hit(bullet.attacker, bullet.target, bullet) then
					bullet:removeSelf()
					table.remove(self.bullets_, index)
				else
					bullet.target = nil
				end
			end
		end
	end
end

local function dist( ax,ay,bx,by )
	local dx,dy = ax - bx, ay - by
	return math.sqrt(dx*dx + dy*dy)
end

return PlayerController