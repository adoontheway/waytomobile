local Hero = import("..models.Hero")

local PlayerController = class("PlayerController")



function PlayerController:ctor()
	--[[self:addNodeEventListener(cc.NODE_EVENT, function(event)
		if event.name == "exit" then
			self.player:getComponent("components.behavior.EventProtocol"):dumpAllEventListeners();
		end
	end)]]
end

function PlayerController:fire(attacker, target)
	if not attacker:canFire() then return end

	attacker:fire()

	local bullet = display.newSprite("gongji_wenzi.png"):addTo(self)
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

function PlayerController:tick()
	local  enemy
	local me = app:getObject("me")	
    local mytarget = me:getTarget()
	if mytarget == nil then
		print("I have no target...")
		me:searchTarget()
	else
		printf("My target id : %s",me:getTarget())
	end

    mytarget = me:getTarget()
    if mytarget == nil then
        print("Win...")
    else
    	enemy = app:getObject(mytarget)
    	local distance = self:dist(enemy:getX(),enemy:getY(), me:getX(), me:getY())
    	if distance < 10 then
    		print("Attack.....")
    	else
    		print("Keep moving....")
    	end
    end
    
	--[[
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
	end]]
end

function PlayerController:dist( ax,ay,bx,by )
	local dx,dy = ax - bx, ay - by
	return math.sqrt(dx*dx + dy*dy)
end

return PlayerController