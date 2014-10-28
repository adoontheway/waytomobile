local  SceneData = class("SceneData")

function SceneData:ctor()
	self.mgr = table.new()
end

function SceneData:parse( bytes )
	-- body
end

function SceneData:getName()
	-- body
	return "NewScene"
end

function SceneData:getLayers()
	-- body
	return []
end

return SceneData