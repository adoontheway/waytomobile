--[[
	技能数据
]]
local SkillVo = class("SkillVo")

function SkillVo:ctor(data)
	if data ~= nil then
		--todo
	end
end

--buff|debuff的冷却时间
function SkillVo:getBuffDuration( )
	-- body
end

--buff|debuf的id
function SkillVo:getBuffId( )
	-- body
end

--冷却时间
function SkillVo:getCoolTime( )
	-- body
end

--技能伤害
function SkillVo:getHarm( )
	-- body
end

--技能类型
function SkillVo:getType( )
	-- body
end

--技能等级
function SkillVo:getLevel( )
	-- body
end

--技能名
function  SkillVo:getName( )
	-- body
end

--技能资源编号
function  SkillVo:getResId(  )
	-- body
end

--使用数据初始化技能数据
function SkillVo:init(data)
	-- body
end

--是否是当前的使用技能
function SkillVo:isUsing()
	-- body
	return true
end

--是否已激活
function SkillVo:isActived()
	-- body
	return false
end

return SkillVo