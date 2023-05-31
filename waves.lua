-- new and update version; v.1.3.1, Updated 5/30/23
local wave = {}; wave.__index = wave
local connector = require(script.Connector)
--/ ...
function wave:Destroy()
	for _, con in ipairs(self.con) do
		con:Disconnect()
	end
end
function wave:Connect(func : (any?) -> (any?))
	local nConnector = connector.new(func)
	self.con[#self.con + 1] = nConnector; return nConnector
end
function wave:Wait()
	-- waits until a connection is fired
	local fired; local newConnection = self:Connect(function()
		fired = true
	end)
	while (self) and (not fired) do
		task.wait(1/30)
	end
	newConnection:Disconnect(); return fired
end
function wave:Fire(...)
	for _, connector in pairs(self.con) do
		if connector.Core then
			connector:work(...)
		end
	end
end
-- ... 
function wave.new()
	local newWave = setmetatable({con = {}}, wave)
	return newWave
end
--/ ...
return wave
