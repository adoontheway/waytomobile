local PlayerController = class("PlayerController")

function PlayerController:ctor()
end

function PlayerController:initEventListener(hero)
end

function PlayerController:tick()
	local  enemy
	local me = app:getObject("me")	
    local mytarget = me:getTarget()
	if mytarget == nil then
		mytarget = me:searchTarget()
	end
    
    if mytarget == nil then
        printLog(10, "Win==============19")
        if me:getState() ~= "walking" then
        	me:walk()
        else
        	me:updatePos()
        end
        
        if me:getX() > display.right + 20 then
        	display.wrapSceneWithTransition(MainScene.new(), "fade", 0.5)
        end
    else
    	enemy = app:getObject(mytarget)
    	if enemy == nil or enemy:isDead() then
    		me:searchTarget()
			mytarget = me:getTarget()

    		if conditions then
    			printLog(10, "Win==============27")
    			me:walk()
    			return
    		end
    	end
    	local distance = self:dist(enemy:getX(),enemy:getY(), me:getX(), me:getY())
    	if distance < me:getRadius() then
    		if me:getState() == "walking" then--走动状态中的话进行待命
    			me:standby()
    		elseif me:getState() == "idle" then--待命状态的话根据冷却时间判断是否攻击
    			if me:canFire() then
    				me:fire(enemy)
    				local percent = math.random(0,10)
	    			local stat_sp
	    			if percent >= 6 then
	    				stat_sp = self:getHarmSp(10,enemy:getX(),enemy:getY()+50)
	    				enemy:decreaseHp(20)
	    			else
	    				stat_sp = self:getHarmSp(0,enemy:getX(),enemy:getY()+50)
	    			end

	    			local parent = display.getRunningScene()
	    			assert(parent ~= nil, "parent is nil") 
	    			assert(stat_sp ~= nil, "stat_sp is nil")
	    			if stat_sp ~= nil and parent ~= nil then
	    				parent:addChild(stat_sp)
	    				transition.execute(stat_sp, CCMoveTo:create(1.0, CCPoint(enemy:getX()-50, enemy:getY()+150)), {
	    					onComplete = function()
	    						stat_sp:removeSelf()
	    					end
	    					})
	    			end
    			else
    				print("Cooling down....")
    			end
    		end
    	else
    		if me:getState() ~= "walking" then
    			me:walk()
    		else
    			me:updatePos()
    		end
    	end
    end
   
end

function PlayerController:getHarmSp( harm, posx, posy )
	local  sp 
	local harmstr = string.format("%d", harm)
	if harm > 0 then
		sp = CCNode:create()
		sp:pos(posx, posy)
		for i=1,#harmstr do
			local tempsp = display.newSprite("fight/"..string.sub(harmstr, i,i)..".png",(i-1)*30,0)
			local size = tempsp:getContentSize()
			printLog(1, "tempsp size w:%f h:%f", size.width, size.height)
			if tempsp ~= nil then
				sp:addChild(tempsp)
			end
		end
	else
		sp = display.newSprite("shanbix_wenzi.png", posx, posy)
	end
	return sp
end

function PlayerController:dist( ax,ay,bx,by )
	local dx,dy = ax - bx, ay - by
	return math.sqrt(dx*dx + dy*dy)
end

function PlayerController:useSkill(skill)
	self.view:useSkill(skill)
end

function PlayerController:control( view )
	self.view = view
end

return PlayerController

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
	end
	]]
--[[

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
end]]