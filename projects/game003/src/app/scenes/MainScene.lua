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
    self.startBtn = cc.ui.UIPushButton.new({normal="res/jinruyouxi_anniu.png"})
    self.startBtn:pos(display.cx, display.cy)
    self.startBtn:onButtonClicked(function( )
        self:initPlayerData()
        app:enterScene("FightScene")
    end)
    self.layer:addChild(self.startBtn)

end

function MainScene:onEnter()
    self.layer:setTouchEnabled(true)
    --app:sendHttpRequest({oper=1,data="login"})
    --[[display.addSpriteFramesWithFile("res/AM/.plist","res/AM/sheet.pvr")
    local am = display.newSprite("Eyes")
    self.layer:addChild(am)]]
end

function MainScene:onTouch(event, x, y)
    print(event)
end

function MainScene:onExit()
end

function MainScene:initPlayerData()
    local player = Hero.new({
        id = "me",
        nickname = "beach",
        level = 1,
        x = display.cx - 150,
        y = display.cy-50,
        direction = -1,
        hp = 100,
        speed = 2,
        res = "Zombie_polevaulter"
    })
    app:setObject("me", player)        


    local enemy = Hero.new({
            id = "enemy",
            nickname = "bitch",
            level = 1,
            hp = 100,
            y = display.cy-50,
            x = display.cx + 150,
            direction = 1,
            res = "Zombie_balloon"
            })
    app:setObject("enemy", enemy)
end

return MainScene
