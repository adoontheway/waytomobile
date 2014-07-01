
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
            self:replaceScene("GameScene")
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
        end})
    self.menu = ui.newMenu({self.item0,self.item1,self.item2})
    self.layer:addChild(self.menu)
end

function MainScene:onEnter()
    self.layer:setTouchEnabled(true)

    if device.platform == "android" then
        -- avoid unmeant back
        self:performWithDelay(function()
            -- keypad layer, for android
            local layer = display.newLayer()
            layer:addKeypadEventListener(function(event)
                if event == "back" then app.exit() end
            end)
            self:addChild(layer)

            layer:setKeypadEnabled(true)
        end, 0.5)
    end
end

function MainScene:onTouch(event, x, y)
    print("hehe")
    print(event)
end

function MainScene:onExit()
end

return MainScene
