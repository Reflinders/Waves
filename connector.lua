-- Instructions: Child this module under the Waves module
local connector = {}; connector.__index = connector
function connector:Disconnect()
	self.Core = nil
end
function connector:work(...)
	task.spawn(self.Core, ...)
end
function connector.new(func : (any?)->())
	return setmetatable({
		Core = func
	}, connector)
end
return connector
