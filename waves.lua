-- new and update version; v.1.3.2, U-6/19/23
local wave = {}; wave.__index = wave
local connector = require(script.Connector)
--/ ...
function wave:Destroy()
	for _, con in ipairs(self.con) do
		con:Disconnect()
	end
end
function wave:Connect(func : (any?) -> (any?)) : connector.Connection
	local nConnector = connector.new(func)
	self.con[#self.con + 1] = nConnector; return nConnector
end
function wave:Wait(meetsConditions : ()->()|nil) : boolean
	-- waits until a connection is fired with met conditions
	local fired; local newConnection = self:Connect(function(...)
		if meetsConditions then
			if meetsConditions(...) then
				fired = true
			end
		else
			fired = true
		end
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
export type Signal = {
	con : {connector.Connection}, -- all the connections
} & typeof(setmetatable({}, wave))
function wave.new() : Signal
	local newWave = setmetatable({con = {}}, wave)
	return newWave
end
--/ ...
return wave
