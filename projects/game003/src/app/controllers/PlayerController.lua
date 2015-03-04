local PlayerController = class("PlayerController")

function PlayerController:ctor()
end

function PlayerController:initEventListener(hero)
end

local times = 0--how many time ticks
local gap = 1--perform a tick with the gap

function PlayerController:tick()	
	times = times + 1
	
	if times%gap ~= 0 then
		printInfo("No beat")
		return
	end

	local me = app:getObject("me")	
    local mytarget = me:getTarget()
    local  enemy = app:getObject(mytarget)
	if mytarget == nil or enemy == nil then
		mytarget = me:searchTarget()
	end
    
    if mytarget == nil then
        if me:getState() == "idle" then
        	me:walk()
        elseif me:getState() == "walking" then
        	me:updatePos()
        end
        
        if me:getX() > display.right - 20 then
        	app:enterScene("MainScene")
        	--display.wrapSceneWithTransition(MainScene.new(), "fade", 0.5)
        end
    else
    	enemy = app:getObject(mytarget)
    	if enemy == nil or enemy:isDead() then
    		me:searchTarget()
			mytarget = me:getTarget()
    		return
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