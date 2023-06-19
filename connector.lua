-- Instructions: Child this module under the Waves module
local connector = {}; connector.__index = connector
function connector:Disconnect()
	self.Core = nil
end
function connector:work(...)
	task.spawn(self.Core, ...)
end
export type Connection = typeof(setmetatable({}, connector))
function connector.new(func : (any?)->()) : Connection
	return setmetatable({
		Core = func
	}, connector)
end
return connector
