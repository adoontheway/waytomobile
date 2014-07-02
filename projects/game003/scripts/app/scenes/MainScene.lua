
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    self.layer = display.newLayer();
    self.bg = display.newSprite("roy.jpg", display.cx, display.cy)
    self.layer:addChild(self.bg)
    self:addChild(self.layer)
    self.item0 = ui.newTTFLabelMenuItem({text = "START", size = 64, align = ui.TEXT_ALIGN_CENTER, 
        x = display.cx, y = display.cy + 50, color = display.COLOR_GREEN,
         listener = function()
            print("Start touched")
            local AnotherScene = require("../scripts/app/scenes/AnotherScene")
            nexScene = AnotherScene:new();
            CCDirector:sharedDirector():replaceScene(CCTransitionFade:create(1, nexScene))
        end})

    self.item1 = ui.newTTFLabelMenuItem({text = "ABOUT", size = 64, align = ui.TEXT_ALIGN_CENTER,
        x=display.cx, y=display.cy,color = display.COLOR_BLUE,
         listener = function()
            print("About touched")
        end})

    self.item2 = ui.newTTFLabelMenuItem({text = "EXIT", size = 64, align = ui.TEXT_ALIGN_CENTER, 
        x=display.cx, y=display.cy-50,color = display.COLOR_RED,
        listener = function()
            print("Exit touched")
            game.exit()
        end})
    self.menu = ui.newMenu({self.item0,self.item1,self.item2})
    self.layer:addChild(self.menu)
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
