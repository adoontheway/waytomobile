--[[
	随从类
]]
local Player = require(".Hero")
local Fellow = class("Fellow", Hero)

Fellow.schema = clone(Hero.schema)
Fellow.schema["ownerId"] = {"number",0}

function Fellow:hit(target)
	local damage = Fellow.super.hit(self, target)
	if damage > 0 then
		self:increaseExp(10)
	end
	return damage
end
-- 主人id，0表示无主人
function Fellow:getOwnerId()
	return self.ownerId_
end

return Fellow