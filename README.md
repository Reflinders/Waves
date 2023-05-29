# Waves
A module that attempts to emulate ROBLOX signals.

Simple Usage Example:
```lua
local RbxEvent = require(Waves)
local NewEvent = RbxEvent.new()
local Connection = NewEvent:Connect(function()
  warn('Hello, world')
end)
-- 
NewEvent:Fire() -- does the code above (warns 'Hello, world')
Connection:Disconnect() -- disconnects the event
NewEvent:Destroy() -- alternatively, you could simply destroy the event and negate any connections
``` 
