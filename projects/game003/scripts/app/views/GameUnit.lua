local GameUnit = class("GameUnit", function()
	-- body
	return display.newNode()
end)

local Progress = import("app.views.Progress")

function GameUnit:ctor(hero)
	-- body
	local clas = hero.class
	cc.EventProxy.new(hero, self)
		:addEventListener(clas.CHANGE_STATE_EVENT, handler(self, self.onStateChange))
		:addEventListener(clas.KILL_EVENT, handler(self, self.onKilled))
		:addEventListener(clas.HP_CHANGED_EVENT, handler(self, self.onHpChanged))
		:addEventListener(clas.EXP_CHANGED_EVENT, handler(self, self.onExpChanged))

	self.player = hero
	self:initDisplay()
end

function GameUnit:onStateChange( event )
	-- body
end

function GameUnit:onKilled( event)
	-- body
end

function GameUnit:onHpChanged( event )
	-- body
end

function GameUnit:onExpChanged( event )
	-- body
end

--初始化显示
function GameUnit:initDisplay()
	-- 角色外观
	local shape
	if self.player ~= nil then
		--todo
		shape = CCArmature:create(self.player:getRes())
		local animation = shape:getAnimation()
		animation:setSpeedScale(0.4)
	    animation:play("anim_idle")
	    self:setPosition(self.player:getX(), self.player:getY())
	    self:setScaleX(self.player:getDirection())
	else
		shape = display.newSprite("defaultimage.png")
	end
	self:addChild(shape)
	self.shape = shape

	--角色血条
	self.hpbar = Progress.new("progres_bg.png","progress.png")
	self:addChild(self.hpbar)
	self.hpbar:setProgress(50)
end
--传入|更新数据
function GameUnit:setData()
	-- body
end
--取得数据
function GameUnit:getData()
	return self.hero
end
--添加事件:重复利用这个对象的时候会用到
function GameUnit:addEvents()
	-- body
end
--移除事件:重复利用这个对象的时候会用到
function GameUnit:removeEvents()
	-- body
end

return GameUnit