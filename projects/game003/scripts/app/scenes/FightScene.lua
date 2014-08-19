--[[
	鎴樻枟鍦烘櫙
]]
local Player = import("app.models.Player")
local Hero = import("app.models.Hero")
local FightUi = import("app.views.FightUi")
local PlayerController = import("app.controllers.PlayerController")
local GameUnit = import("app.views.GameUnit")

local FightScene = class("FightScene", function()
    return display.newScene("FightScene")
end)

local controller = nil
local handler = nil

local scheduler = import("framework.scheduler")
local spMaps = nil

function FightScene:ctor()
	self.speed = 100;
	self.curBehaviorId = 1;
    self.layer = display.newLayer()
    self:addChild(self.layer)
    self.layer:setTouchEnabled(true)
    self.bg = display.newSprite("battle_bg/bbg_corridor_ruin.jpg",display.cx, display.cy)
    self.layer:addChild(self.bg)
    self.players = {}
    self.ui = FightUi.new()
    --self.ui:setPosition(0, display.bottom-150)
    self.layer:addChild(self.ui)
    
end

function FightScene:addPlayer(playerId)
	local player = self,players[playerId]
	if player ~= nil then
		local res = player:getRes()
	end
end


function FightScene:onTouch(event)
	print("Touched.....")
end

function FightScene:onEnterFrame()
    app:getController():tick(spMaps)
end

function FightScene:onEnter()
    spMaps = {}

    local manager = CCArmatureDataManager:sharedArmatureDataManager()
    manager:addArmatureFileInfo("Zombie.png","Zombie.plist","Zombie.xml")
    local attacker = app:getObject("me")
    local attackerSp = GameUnit.new(attacker)
    self.layer:addChild(attackerSp)
    

    local enemy = app:getObject("enemy")
    local attackerSp1 = GameUnit.new(enemy)
    self.layer:addChild(attackerSp1)

    spMaps["me"] = attackerSp
    spMaps["enemy"] = attackerSp1
    --[[
    self.layer:addNodeEventListener(cc.NODE_TOUCH_EVENT, function( event )
    	self.onTouch(event)
    end)
    self.layer:setTouchEnabled(true)
    ]]

    handler = scheduler.scheduleGlobal(self.onEnterFrame, 0.3)
    app:getController():control(self)
end

function FightScene:onExit()
    if handler ~= nil then
        scheduler.unscheduleGlobal(handler)
    end
end

function FightScene:useSkill()
    -- body
    print("Use skill....")
    local target = spMaps["enemy"]
    CCTexture2D:PVRImagesHavePremultipliedAlpha(true)
    CCSpriteFrameCache:sharedSpriteFrameCache():addSpriteFramesWithFile("wuleizhou.plist")
    local effectShape = display.newSprite("wuleizhou.png")
    local frames = CCArray:create()
    for i=1,11 do
        local framename = string.format("thunder%i.png", i)
        printf("FrameName....", framename)
        local frame = CCSpriteFrameCache:sharedSpriteFrameCache():spriteFrameByName(framename)
        if frame ~= nil then
            frames.addObject(frame)
        end
    end

    local  animation = CCAnimation:createWithSpriteFrames(frames)
    effectShape:runAction(CCAnimate:create(animation))
    effectShape:pos(target:getPositionX(), target:getPositionY())
end

return FightScene