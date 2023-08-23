-- v.1.3.3 -- 7/1/23
local wave = {}; wave.__index = wave
--/ ...
function wave.newConnector(func : ()->()?)
	local newConnection = {Core = func}; do
		function newConnection:Disconnect()
			self.Core = nil
		end
		function newConnection.Work(...)
			task.spawn(newConnection.Core, ...)
		end
	end
	return newConnection
end
function wave:Destroy()
	for _, con in ipairs(self.con) do
		con:Disconnect()
	end
end
function wave:Connect(func : (any?) -> (any?)) : connector.Connection
	local nConnector = wave.newConnector(func)
	self.con[#self.con + 1] = nConnector; return nConnector
end
function wave:Wait(meetsConditions : (any?)->(boolean)|nil)
	-- waits until a connection is fired with met conditions
	local args
	local fired; local newConnection = self:Connect(function(...)
		if meetsConditions then
			if meetsConditions(...) then
				args = {...}
				fired = true
			end
		else
			args = {...}
			fired = true
		end
	end)
	while (self) and (not fired) do
		task.wait(1/30)
	end
	newConnection:Disconnect(); return unpack(args)
end
function wave:Fire(...)
	for _, connector in pairs(self.con) do
		if connector.Core then
			connector.Work(...)
		end
	end
end
-- ... 
export type Signal = typeof(setmetatable({}, wave))
function wave.new() : Signal
	local newWave = setmetatable({con = {}}, wave)
	return newWave
end
--/ ...
return wave

