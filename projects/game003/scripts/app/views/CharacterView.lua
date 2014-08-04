--[[
	角色在场景中的状态显示类：血条，蓝条，技能冷却等
]]
local  CharacterView = class("CharacterView", function()
		return display.newNode()
end)
--建立一些必备资源
function CharacterView:ctor()
	self:setTouchEnabled(true)
	self.head = display.newSprite("default_head.jpg")--默认头像
	self:addChild(self.head)
	--[[
	self.hpBar = display.newSprite(filename, x, y, params)--hp进度条
	self.mpBar = display.newSprite(filename, x, y, params)--mp进度条
	]]
	self.skills = {};--技能容器,需要设定最多使用几个技能
end
--生成一个技能显示item
function CharacterView:genSkillItem(skill,item)
	if item == nil then
		item = diaplay.newSprite(skill:getResId())
	else
			
	end
end
--进入场景的时候更新显示
function CharacterView:onEnter()
	local me = app:getObject("me")
	local skills = me:getSkills()
	local skillNum = 1;
	for k,v in pairs(skills) do
		if v:isUsing() then
			local skillItem
			if self.skillItem[skillNum] ~= nil then
				skillItem = self.skills[skillNum]
			else
				skillItem = self:genSkillItem()
				self.skills[skillNum] = skillItem
			end
			skillNum = skillNum + 1
		end
	end
end
--退出场景的时候回收资源
function CharacterView:onExit()
	
end

return CharacterView