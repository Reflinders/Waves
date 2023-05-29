--/ ... Emulator of roblox events/signals
--/ Newly updated version; v.1.3, Updated 5/28/23
--
--/ ... @Reflinders on Github
--
local wave = {}; wave.__index = wave
local connector = require(script.Connector)
--/ ...
function wave:Destroy()
	for _, con in ipairs(self.Connections) do
		con:Disconnect()
	end
	self.Destroyed = true
end
function wave:Connect(func : (any?) -> (any?))
	assert(not self.Destroyed, 'Waves: Attempt to connect to a destroyed signal @ ' .. debug.traceback())
	local nConnector = connector.new(func)
	self.Connections[#self.Connections + 1] = nConnector; return nConnector
end
function wave:Wait(callback : ((any?) -> (any?))|string?)
	while self and not (if typeof(callback) == 'function' then callback(self) else self[callback]) do
		task.wait(1/30)
	end
end
function wave:Fire(...)
	assert(not self.Destroyed, 'Waves: Attempt to fire a destroyed signal @ ' .. debug.traceback())
	for _, connector in pairs(self.Connections) do
		if connector.Core then
			connector:work(...)
		end
	end
end
--/ ... 
export type WaveSignal = typeof(setmetatable({}, wave))
--/ ...
function wave.new() : WaveSignal
	return setmetatable({Connections = {}}, wave)
end
--/ ...
return wave
