--[[
	技能数据
]]
local SkillVo = class("SkillVo")

function SkillVo:ctor(data)
	if data ~= nil then
		self.name = data.name
		self.id = data.id
		self.icon = data.icon
	end
end

--图标资源
function SkillVo:getIconRes(  )
	return self.icon
end

--子弹资源
function SkillVo:getBulletRes()
	return self.bullet
end

--buff或者debuff资源
function SkillVo:getBuffRes()
	return self.buffRes
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

--受众数量
function SkillVo:targetQty()
	-- body
end

--受众对象：己方或者对方
function SkillVo:target()
	
end
--技能类型 1 主动攻击 2 主动buff 
function SkillVo:getType()
	-- body
end

--技能等级
function SkillVo:getLevel( )
	-- body
end

--技能名
function  SkillVo:getName( )
	return self.name
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