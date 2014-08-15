--[[
    欢迎界面
]]
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)
local MainUi = import("app.views.MainUi")
local Player = import("app.models.Player")
local Hero = import("app.models.Hero")
local FightScene = import("app.scenes.FightScene")

function MainScene:ctor()
    self.instance = self
    self.layer = display.newLayer();
    self.ui = MainUi.new()
    self:addChild(self.layer)
    self.ui:addTo(self.layer)
    self.item0 = ui.newTTFLabelMenuItem({text = "START", size = 64, align = ui.TEXT_ALIGN_CENTER, 
        x = display.cx, y = display.cy + 50, color = display.COLOR_GREEN,
         listener = function()
            local nexScene = FightScene.new()
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
    
    if not app:isObjectExists("me") then
        local player = Hero.new({
            id = "me",
            nickname = "beach",
            level = 1,
            x = display.cx - 150,
            y = display.cy,
            direction = -1,
            speed = 10,
            res = "Zombie_polevaulter"
        })
        app:setObject("me", player)

        local enemy = Hero.new({
            id = "enemy",
            nickname = "bitch",
            level = 1,
            y = display.cy,
            x = display.cx + 150,
            direction = 1,
            res = "Zombie_balloon"
            })
        app:setObject("enemy", enemy)
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
