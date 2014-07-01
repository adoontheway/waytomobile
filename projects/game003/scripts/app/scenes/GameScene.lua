local GameScene = class("GameScene", function()
    return display.newScene("GameScene")
end)

function GameScene:ctor()
    print("Constructor of GameScene")
end

function GameScene:onEnter()
    print("Custom GameScene:onEnter")
    ui.newTTFLabel({text = "GameScene", size = 64, align = ui.TEXT_ALIGN_CENTER})
        :pos(display.cx, display.cy)
        :addTo(self)
end
return GameScene