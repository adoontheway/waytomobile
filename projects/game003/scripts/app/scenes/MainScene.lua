--[[
    欢迎界面
]]
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

local Player = require("app.models.Player")
local Hero = require("app.models.Hero")
local AnotherScene = require("app.scenes.AnotherScene")

function MainScene:ctor()
    self.instance = self
    self.layer = display.newLayer();
    self.bg = display.newSprite("roy.jpg", display.cx, display.cy)
    self.layer:addChild(self.bg)
    self:addChild(self.layer)
    self.item0 = ui.newTTFLabelMenuItem({text = "START", size = 64, align = ui.TEXT_ALIGN_CENTER, 
        x = display.cx, y = display.cy + 50, color = display.COLOR_GREEN,
         listener = function()
            local nexScene = AnotherScene:new()
            nexScene.attacker = 1
            nexScene.defender = 2
            local transition = display.wrapSceneWithTransition(nexScene,"fade",0.5)
            display.replaceScene(nexScene)
        end})

    self.item1 = ui.newTTFLabelMenuItem({text = "ABOUT", size = 64, align = ui.TEXT_ALIGN_CENTER,
        x=display.cx, y=display.cy,color = display.COLOR_BLUE,
         listener = function()
        end})

    self.item2 = ui.newTTFLabelMenuItem({text = "EXIT", size = 64, align = ui.TEXT_ALIGN_CENTER, 
        x=display.cx, y=display.cy-50,color = display.COLOR_RED,
        listener = function()
            game.exit()
        end})
    self.menu = ui.newMenu({self.item0,self.item1,self.item2})
    self.layer:addChild(self.menu)
    
    if not app:isObjectExists("hehe") then
        local player = Hero.new({
            id = "me",
            nickname = "beach",
            level = 1
        })
        app:setObject("me", player)
    end
end

function MainScene:onEnter()
    self.layer:setTouchEnabled(true)
    
end

function MainScene:onTouch(event, x, y)
    print(event)
end

function MainScene:onExit()
end

return MainScene
