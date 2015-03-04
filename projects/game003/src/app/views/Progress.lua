local Progress = class("Progress", function( background, fill )
	-- body
	local progress = display.newSprite(background)
	local fill = display.newProgressTimer(fill, display.PROGRESS_TIMER_BAR)
	fill:setMidpoint(CCPoint(0,0.5))
	fill:setBarChangeRate(CCPoint(1.0,0))
	fill:setPosition(progress:getContentSize().width*0.5, progress:getContentSize().height*0.5)
	progress:addChild(fill)
	progress:scale(0.5)
	fill:setPercentage(100)
	progress.fill = fill
	return progress
end)

function Progress:ctor( )
end

function Progress:setProgress(progress)
	-- body
	self.fill:setPercentage(progress)
end

return Progress