local JoyStick = class("JoyStick", function(bgm, bgs, touchres)
	local bgm = display.newSprite(bgm)
	local bgs = display.newSprite(bgs)
	local touch = display.newSprite(touchres)

	bgm:setAnchorPoint(display.ANCHOR_POINTS[display.CENTER])
	bgs:setAnchorPoint(display.ANCHOR_POINTS[display.CENTER])
	touch:setAnchorPoint(display.ANCHOR_POINTS[display.CENTER])
	local node = display.newNode()
	node:addChild(bgm)
	node:addChild(bgs)
	node:addChild(touch)
	node.halfRad = bgs:getContentSize().width*.5--reference of walk and run
	node.fullRad = bgm:getContentSize().width*.5
	node.bgm = bgm
	node.bgs = bgs
	node.touch = touch
	node.touch = touch
	node.tx = node.halfRad
	node.ty = bgs:getContentSize().height*.5
	node:setAnchorPoint(display.ANCHOR_POINTS[display.CENTER])
	return node
end)

JoyStick.MOVE = "MOVE"
JoyStick.STOP = "STOP"
JoyStick.RIGHT = 1
JoyStick.LEFT = -1

function JoyStick:ctor()
end

function JoyStick:control( player, callback )
	self.player = player
	self.callback = callback
	if self.flag == false or self.flag == nil then
		self:ready()
	end
end

function JoyStick:ready()
	self.flag = true
	self:setTouchEnabled(true)
	self:addNodeEventListener(cc.NODE_TOUCH_EVENT, handler(self, self.onTouched),1000, 9999)
end

function JoyStick:onTouched(event)
	print(event.x, event.y)
	self.touch:pos(event.x - self.halfRad, event.y - self.halfRad)
	local dis = dist(event.x - self.halfRad,event.y - self.halfRad,self.tx,self.ty)
	if math.abs(dis) >= self.halfRad then
		self.fullEng = true
	else
		self.fullEng = false
	end
	local tx = event.x - self.tx - self.halfRad
	local ty = event.y - self.ty - self.halfRad
	self.tx = tx/dis
	self.ty = ty/dis
	if tx >= 0 then
		self.direction = JoyStick.RIGHT
	else
		self.direction = JoyStick.LEFT
	end

	if self.callback ~= nil then
		self.callback()
	end
end

function JoyStick:getState()
	return self.state
end

function JoyStick:getDir( )
	return self.tx,self.ty
end

function JoyStick:isFullEng( )
	return self.fullEng
end

function JoyStick:getDirection( )
	return self.direction
end

function dist( x0,y0,x1,y1 )
 	local dx = x0 - x1
	local dy = y0 - y1
	return math.sqrt(dx*dx+dy*dy)
 end 

return JoyStick