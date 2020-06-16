--[[
CREATED BY ALGORITIMI
EDITED BY DEVOLLIN
Originally for Baked Bakery V2

Usage:
	local timer = script.new(obkect, props, modifiers)
	script:Play()
	script:Pause()
	script:Cancel()

Description:
	Timer based on the RunService.Stepped event. Stopped timers do not retain their 
	remaining time.
]]

local timers = {}
local Easing = require(script.Parent.Easing)

local module = {}
module.__index = module

function module.new(object, props, modifiers)
	assert(type(modifiers.T) == 'number', 'Duration was not a number!')
	local self = setmetatable({}, module)
	self.Debounce = false
	self.InitDuration = modifiers.T
	self.Duration = 0
	self.Paused = false
	self.Easing = Easing.new(modifiers.T, object, props, modifiers.ES)
	self.Callback = function ()
		modifiers.CB(self.Easing.Subject)
	end
	self.Completed = modifiers.Completed and function ()
		if (not self.Debounce) then
			self.Debounce = true
			modifiers.Completed()
			self.Debounce = false
		end
	end
	table.insert(timers, self)
	return self
end

function module:Play()
	if not self.Paused then
		self.Duration = self.InitDuration
	else
		self.Paused = false
	end
end

function module:Pause()
	self.Paused = true
end

function module:Cancel()
	self.Duration = 0
	self.Paused = false
end

game:GetService("RunService").Stepped:Connect(function (t, s)
	local oldDuration, newDuration
	local _
	for i, v in next, timers do
		if not v.Paused then
			oldDuration = v.Duration
			newDuration = oldDuration - s
			_ = (not (oldDuration>0 and newDuration<=0)) or (v.Completed and spawn(v.Completed))
			v.Duration = ((newDuration > 0) and newDuration or 0)
			v.Easing:Set(v.Duration)
			spawn(v.Callback)
		end
	end
end)

return module
