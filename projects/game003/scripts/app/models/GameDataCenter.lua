--[[
	全局数据持有类
]]
local GameDataCenter = class("GameDataCenter")

local Player = require(".Player")
local Hero = require(".Hero")
local PlayerController = require("..controllers.PlayerController")

function GameDataCenter:ctor()
	self.instance = self
end
--读取自己的信息
function GameDataCenter:getSelfData( ... )
	-- body
end
--添加角色
function GameDataCenter:addPlayer( id, rawid )
	-- body
end
--删除角色
function GameDataCenter:delPlayer( id )
	-- body
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