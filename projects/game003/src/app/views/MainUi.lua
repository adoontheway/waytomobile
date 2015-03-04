--[[
	主场景ui，非战斗下的ui
]]
local MainUi = class("MainUi", function()
	-- body
	return display.newNode()
end)

function MainUi:ctor()
	-- body
	self.bg = display.newSprite("main/main_bg_grass_left.jpg", display.cx, display.cy)
	self.bg1 = display.newSprite("main/main_bg_grass_right.jpg", self.bg:getContentSize().width, display.cy)
	self.layer = display.newLayer()
	self.layer:addTo(self)
	self.bg:addTo(self.layer)
	--self.head = display.newSprite("portrait/", x, y, params)
	--self.bg1:addTo(self.layer)
end
--在enter场景的时候添加事件监听，并初始化相关资源
function MainUi:onEnter()
	-- body
end
--在exit的时候删除事件监听，并回收相关资源
function MainUi:onExit()
	-- body
end

return MainUi