local JoyStick = class("JoyStick", function(bg, touchres, arrow)
	local background = display.newSprite(bg)
	local touch = display.newSprite(touchres)
	local arrowup = display.newSprite(arrow)
	arrowup:pos(0, 22)
	arrowup:setAnchorPoint(display.ANCHOR_POINTS[display.BOTTOM_CENTER])
	local arrowdown = display.newSprite(arrow)
	arrowdown:rotation(180)
	arrowdown:pos(0, -22)
	arrowdown:setAnchorPoint(display.ANCHOR_POINTS[display.BOTTOM_CENTER])
	local arrowleft = display.newSprite(arrow)
	arrowleft:rotation(-90)
	arrowleft:pos(-22, 0)
	arrowleft:setAnchorPoint(display.ANCHOR_POINTS[display.BOTTOM_CENTER])
	local arrowright = display.newSprite(arrow)
	arrowright:rotation(90)
	arrowright:pos(22, 0)
	arrowright:setAnchorPoint(display.ANCHOR_POINTS[display.BOTTOM_CENTER])

	background:setAnchorPoint(display.ANCHOR_POINTS[display.CENTER])
	touch:setAnchorPoint(display.ANCHOR_POINTS[display.CENTER])
	local node = display.newNode()
	node:addChild(background)
	node:addChild(touch)
	node:addChild(arrowup)
	node:addChild(arrowdown)
	node:addChild(arrowleft)
	node:addChild(arrowright)
	node.background = background
	node.touchbg = touch
	return node
end)

function JoyStick:ctor( )
	-- body
end

function JoyStick:setCallbacks(onDirectionChangd, onPowerChange)
	-- body
end

function JoyStick:getDirection()
	-- body
end

function JoyStick:onPowerChange()
	-- body
end

return JoyStick