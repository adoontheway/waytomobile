
require("config")
require("framework.init")
require("framework.shortcodes")
require("framework.cc.init")

local MyApp = class("MyApp", cc.mvc.AppBase)

function MyApp:ctor()
    MyApp.super.ctor(self)
    self.objects_ = {}
end

function MyApp:run()
    CCFileUtils:sharedFileUtils():addSearchPath("res/")
    self:enterScene("MainScene")
end

function MyApp:setObject(id, object)
	assert(self.objects_[id] == nil, string.format("MyApp:setObject() -id \"%s\" already exists",id))
	self.objects_[id] = object
end

function MyApp:getObject(key)
	assert(self.objects_[key] ~= nil, string.format("MyApp:getObject() -id \"%s\" not exists",key))
	return self.objects_[key]
end

function MyApp:isObjectExists(key)
	return self.objects_[key] ~= nil
end

function MyApp:getTarget(source)
	for k,v in pairs(self.objects_) do
		if v:isDead() ~= true then
			if v:getId() ~= source:getId() then--todo 暂时只判断两个的id不相等，后续添加随从之后用ownerId判断
				return k
			end
		end
	end
	return nil
end

function MyApp:getController()
	if self.controller == nil then
		self.controller = require("app.controllers.PlayerController").new()
	end
	return self.controller
end

return MyApp
