--[[
	技能显示条目
]]
local SkillItem = class("SkillItem", function( )
	return display.newNode()
end)

function SkillItem:ctor()
end

function SkillItem:setSkill( skillVo)
	self.skill = skillVo
	self:updateDisplay()
end

function SkillItem:updateDisplay()
	self.icon = display.newSprite(skillVo:getResId())
end

--todo 需要做冷却的进度显示
function SkillItem:updateCoolMask()
	-- body
end

return SkillItem