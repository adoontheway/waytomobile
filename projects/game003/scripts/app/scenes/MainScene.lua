
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    self.layer = display.newLayer();
    self:addChild(self.layer)
    self.item0 = ui.newTTFLabelMenuItem({text = "START", size = 64, align = ui.TEXT_ALIGN_CENTER, 
        x = display.cx, y = display.cy + 50,
         listener = function()
            print("Start printed")
            nexScene = display.newScene("GameScene");
            transition = display.wrapSceneWithTransition(nexScene, "fade", 1.0)
            display.replaceScene(nexScene)
        end})

    self.item1 = ui.newTTFLabelMenuItem({text = "ABOUT", size = 64, align = ui.TEXT_ALIGN_CENTER,
        x=display.cx, y=display.cy,
         listener = function()
            print("About printed")
        end})

    self.item2 = ui.newTTFLabelMenuItem({text = "EXIT", size = 64, align = ui.TEXT_ALIGN_CENTER, 
        x=display.cx, y=display.cy-50,
        listener = function()
            print("Exit printed")
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
