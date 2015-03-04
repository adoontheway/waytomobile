--[[
	AI类，用于场景对象的只能控制
]]
local AI = class("AI")

AI.WANDER_STATE = "wander"--wander state
AI.TARGETING_STATE = "targeting"--targeting state
AI.ENAGE_STATE = "engage"-- engage state

function AI:ctor()
	self.masters = table.new({})--master map id:state
end

function AI:getCurState()

end

function AI:tick()

end

function AI:wander( ... )
	-- body
end

function AI:target( ... )
	-- body
end

function AI:engage( ... )
	-- body
end

--计算距离
function AI:getDistance(one, two)
	return 0
end

return AI