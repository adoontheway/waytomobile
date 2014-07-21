--[[
	全局数据持有类
]]
local GameDataCenter = class("GameDataCenter")

local Player = require("app.models.Player")
local Hero = require("app.models.Hero")

function GameDataCenter:ctor()
	self.players = {}
	self.curId = 0
end

function GameDataCenter:Instance( )
	-- body
	if self.instance == nil then
		self.instance = self.new()
	end
	return self.instance
end
--生成一个全局唯一id
function GameDataCenter:generateId()

end
--读取自己的信息
function GameDataCenter:getSelfData( ... )
	-- body
end
--寻找玩家数据
function GameDataCenter:getPlayerById(id)
	if self.players ~= nil and #self.players ~= 0 then
		return self.players[id]
	end
	return nil
end
--添加角色
function GameDataCenter:addPlayer( id, player )
	if self.curId < id then
		self.curId =  id 
	end
	self.players[id] = player
end
--删除角色
function GameDataCenter:delPlayer( id )
	-- body
	self.players[id] = nil
end
--发送消息到服务端
function GameDataCenter:sendMsg( )
	-- body
end
--读取服务端返回信息
function GameDataCenter:readMsg( )
	-- body
end

return GameDataCenter