--[[
	角色类，继承自玩家类
]]
local Player = import(".Player")
local Hero = class("Hero", Player)

Hero.EXP_CHANGED_EVENT = "EXP_CHANGED_EVENT"
Hero.LEVEL_UP_EVENT = "LEVEL_UP_EVENT"

Hero.schema = clone(Player.schema)
Hero.schema["exp"] = {"number",0}
-- 升到下一级需要的经验值
Hero.NEXT_LEVEL_EXP = 50

function Hero:increaseExp(exp)
	assert(not self:isDead(), string.format("Hero %s:%s is dead, can't increase Exp", self:getId(), self:getNickName()))
	assert(exp > 0 , string.format("Invalid exp value: %s in Hero:increaseExp",exp))

	self.exp_ = self.exp_ + exp

	while self.exp_ >= Hero:getNextLevelExp() do
		self.level_ = self.level_ + 1
		self.exp_ = self.exp_ - Hero:getNextLevelExp()
		self:setFullHp()
		self:dispatchEvent({name=Hero.LEVEL_UP_EVENT})
	end
	self:dispatchEvent({name = Hero.EXP_CHANGED_EVENT}) 
	return self
end

function Hero:getExp()
	return self.exp_;
end

function Hero:hit(target)
	local damage = Hero.super.hit(self, target)
	if damage > 0 then
		self:increaseExp(10)
	end
	return damage
end

---添加随从
function Hero:addFellow()
end

--取得随从
function Hero:getFellows( ... )
	-- body
end

return Hero