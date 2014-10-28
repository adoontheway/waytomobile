--[[
	Fight scene of the game
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
local tickhandler = nil

local scheduler = import("framework.scheduler")
local spMaps = nil

function FightScene:ctor()
	self.speed = 100;
	self.curBehaviorId = 1;
    self.layer = display.newLayer()
    self.layer:setTouchEnabled(true)
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

function FightScene:onEnterFrame(dt)
    app:getController():tick(spMaps)
     --更新显示:用显示去更新数据，这个是不对的
    for key,sp in pairs(spMaps) do
        local data = app:getObject(key)
        if data ~= nil then
            if not data:isDead() then
                sp:setPosition(data:getX(), data:getY())--sp要在场景中移除
            elseif data:getParent() == nil then
                spMaps[key] = nil
            else
                spMaps[key] = nil
                app:removeObject(key)
            end
        else
            spMaps[key] = nil
        end
    end
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

    local selfView = GUIReader:shareReader():widgetFromJsonFile("NewUi/NewUi_1.ExportJson")
    self:addChild(selfView)
    selfView:setTouchEnabled(true)
    selfView:addNodeEventListener(cc.NODE_TOUCH_EVENT, function( event )
        printInfo("UI touched")
    end)
    --[[
    selfView:setVisible(false)
    local btn = selfView:getChildByTag(4)
    if btn ~= nil then
        btn:setTouchMode(cc.TOUCH_MODE_ONE_BY_ONE)
        btn:setTouchEnabled(true)
        btn:setTouchSwallowEnabled(false)
        btn:addNodeEventListener(cc.NODE_TOUCH_EVENT,function(event)
            printLog(100, "Button on UI touched...")
        end)
    end
    self.layer:addNodeEventListener(cc.NODE_TOUCH_EVENT, function( event )
    	self.onTouch(event)
    end)]]
    
    
    tickhandler = scheduler.scheduleGlobal(handler(self,self.onEnterFrame), 1/60)
    app:getController():control(self)
end

function FightScene:onExit()
    if tickhandler ~= nil then
        scheduler.unscheduleGlobal(tickhandler)
    end

    for id,sp in pairs(spMaps) do
        if sp:getParent() ~= nil then
            sp:removeSelf()
            app:removeObject(id)
        end
        spMaps[id] = nil
    end
end

function FightScene:useSkill(skill)
    -- body
    print("Use skill...."..skill:getName())
    local target = spMaps["enemy"]
    CCTexture2D:PVRImagesHavePremultipliedAlpha(true)
    CCSpriteFrameCache:sharedSpriteFrameCache():addSpriteFramesWithFile("thunder.plist")
    
    local frames = display.newFrames("image %i.png", 1, 19)
    local animation = display.newAnimation(frames, 0.1)
    display.setAnimationCache("thunder",animation)

    local effectShape = display.newSprite(frames[1])
    effectShape:setAnchorPoint(CCPoint(0.5,0))
    effectShape:playAnimationOnce(animation,true)
    effectShape:pos(target:getPositionX(), target:getPositionY())
    self:addChild(effectShape)
end

return FightScene