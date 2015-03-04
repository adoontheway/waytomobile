local WelcomeView = class("WelcomeView", function()
	return display.newNode()
end)
local MainScene = require("MainScene")

function WelcomeView:ctor()
	display.newSprite(filename, display.cx, display.cy)--背景
		:addTo(self)

	ui.newEditBox({size = size(200, 40),x=display.cx, y=display.cy+50})--用户名输入框
		:addTo(self)

	ui.newEditBox({size = size(200, 40),x=display.cx, y=display.cy-50})--密码输入框
		:setInputFlag(0)
		:addTo(self)
	cc.ui.UIPushButton.new("jinruyouxi_anniu.png", options)
		:onButtonPressed(function( event )
			event.target:setScale(1.1)
		end)
		:onButtonRelease(function(event)
			event.target.scale(1.0)
		end)
		:onButtonClicked(function(event)
			--进入游戏
			display.wrapSceneWithTransition(scene, transitionType, time, more)
		end)
		:pos(display.cx + 300, display.bottom +100)
		:addTo(self)
end

return WelcomeView