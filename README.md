# Waves
Roblox events..

```lua
local RbxEvent = require(Waves)
local NewEvent = RbxEvent.new()
local Connection = NewEvent:Connect(function()
  warn('wtv')
end)
NewEvent:Fire() -- does the code above (warn 'wtv')
Connection:Disconnect() -- self-explanatory
``` 
