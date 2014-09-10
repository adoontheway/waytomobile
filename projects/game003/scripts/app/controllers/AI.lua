--[[
	AI类，用于场景对象的只能控制
]]
local AI = class("AI")

function AI:ctor()
	
end

--控制宿主
function AI:control(master)
	self.master = master
	master.ai = self
end

--以下部分伪代码
function AI:tick()
	if self.master ~= nil then
		if self.master:getTarget() == nil then--没有目标的话找目标
			self.master:searchTarget()
		end

		if self.master:getRadius() < self:getDistance(self.master,self.master:getTarget())--判断是否在攻击范围内
			if not self.master:getTarget():isDead() then
				if self.master:getStatus() ~= "firing" then
					self.master:fire(self.master:getTarget())
				end
			end
		elseif self.master:getStatus() ~= "walking" then
			self.master:walk()
		end
	end
end

--计算距离
function AI:getDistance(one, two)
	return 0
end

return AI