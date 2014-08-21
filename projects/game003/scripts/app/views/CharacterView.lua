--[[
	角色在场景中的状态显示类：血条，蓝条，技能冷却等
]]
local SkillVo = require("app.models.SkillVo")
local SkillItem = require("app.views.SkillItem")

local  CharacterView = class("CharacterView", function()
		return display.newNode()
end)
--建立一些必备资源
function CharacterView:ctor()
	self:setTouchEnabled(true)
	self.head = display.newSprite("hero/AM.jpg")--默认头像
	self:addChild(self.head)
	--[[self.mpBar = display.newSprite(filename, x, y, params)--mp进度条
	]]
	local skill = SkillVo.new({name="skill001",id="skill001",icon="item/s403.jpg"})
	local skillItem = self:genSkillItem(skill)
	skillItem:setPosition(100, 10)
	skillItem:addNodeEventListener(cc.NODE_TOUCH_EVENT, function( event )
    	app:getController():useSkill(skill)
    end)
    skillItem:setTouchEnabled(true)
	self:addChild(skillItem)

	local skill1 = SkillVo.new({name="skill002",id="skill002",icon="item/s423.jpg"})
	local skillItem1 = self:genSkillItem(skill1)
	skillItem1:setPosition(200, 10)
	skillItem1:addNodeEventListener(cc.NODE_TOUCH_EVENT, function( event )
    	app:getController():useSkill(skill1)
    end)
    skillItem1:setTouchEnabled(true)
	self:addChild(skillItem1)

	self.skills = {};--技能容器,需要设定最多使用几个技能
end
--生成一个技能显示item
function CharacterView:genSkillItem(skill,item)
	--if item == nil then
		item = display.newSprite(skill:getIconRes())--skill:getResId())
        return item
	--else
			
	--end
end
--进入场景的时候更新显示
function CharacterView:onEnter()
	local me = app:getObject("me")
	local skills = me:getSkills()
	
	--[[local skillNum = 1;
	for k,v in pairs(skills) do
		if v:isUsing() then
			local skillItem
			if self.skillItem[skillNum] ~= nil then
				skillItem = self.skills[skillNum]
			else
				skillItem = self:genSkillItem("item/s403.jpg")
				self.skills[skillNum] = skillItem
				skillItem:setPosition(100*skillNum, 0)
				self:addChild(skillItem)
			end
			skillNum = skillNum + 1
		end
	end]]
end

function CharacterView:playSkillCall(callback)
	self.callBack = callback
end

--退出场景的时候回收资源
function CharacterView:onExit()
	
end

return CharacterView