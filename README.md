# Waves
A module that attempts to emulate ROBLOX signals. Get New Version(s) @ Releases.

Simple Usage Example:
```lua
local RbxEvent = require(Waves)
local NewEvent = RbxEvent.new()
local Connection = NewEvent:Connect(function()
  warn('Hello, world')
end)
-- 
task.delay(1, function()
   NewEvent:Fire()  -- does the code above (warns 'Hello, world')
end); NewEvent:Wait() -- waits until the event is fired (so the wait yields in 1 second, since the thread above is delayed by one second)
Connection:Disconnect() -- disconnects the event
NewEvent:Destroy() -- alternatively, you could simply destroy the event and negate any connections
``` 
