local GameScene = class("GameScene", function()
    return display.newScene("GameScene")
end)

function GameScene:ctor()

    ui.newTTFLabel({text = "GameScene", size = 64, align = ui.TEXT_ALIGN_CENTER})
        :pos(display.cx, display.cy)
        :addTo(self)
end

return GameScene