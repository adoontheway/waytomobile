
require("config")
require("cocos.init")
require("framework.init")

local MyApp = class("MyApp", cc.mvc.AppBase)

function MyApp:ctor()
    MyApp.super.ctor(self)
    self.objects_ = {}
    self.aipool = {}
    self.sceneMgr = require("app.models.SceneDataMgr").new()
    self.communicator = require("app.controllers.Communication").new()
end

function MyApp:run()
    cc.FileUtils:getInstance():addSearchPath("res/")
    self:enterScene("MainScene")
end

function MyApp:setObject(id, object)
	assert(self.objects_[id] == nil, string.format("MyApp:setObject() -id \"%s\" already exists",id))
	self.objects_[id] = object
end

function MyApp:removeObject(id)
	self.objects_[id] = nil 
end

function MyApp:getObject(key)
	return self.objects_[key]
end

function MyApp:isObjectExists(key)
	return self.objects_[key] ~= nil
end

function MyApp:getTarget(source)
	for k,v in pairs(self.objects_) do
		if v ~= nil or not v:isDead() then
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
--generate a ai with the same name of the gameunit
function MyApp:genAI(name)
	if self.aipool[name] == nil then
		self.aipool[name] = AI.new()
	end
end

function MyApp:sendHttpRequest( param )
	self.communicator:doRequest(param)
end

return MyApp
