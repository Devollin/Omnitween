-- Omnitween | V1.0.0 | Written by Devollin
local Timers = require(script.Timers)

-- Used to tween models, without using :SetPrimaryPartCFrame(), which causes inconsistencies over time.
local function SetModelCFrame(Model, NewCFrame)
	for Ind, Child in pairs(Model:GetDescendants()) do
		if Child:IsA("BasePart") then
			Child.CFrame = NewCFrame * Model.PrimaryPart.CFrame:Inverse() * Child.CFrame
		end
	end
end

-- Base tween function used for Instances.
local function Pure(Obj, Prop, Dat)
	return game:GetService('TweenService'):Create(Obj, TweenInfo.new(Dat.T, Dat.ES, Dat.ED, Dat.RC, Dat.R, Dat.DT), Prop)
end

-- Tweens Instances that are applicable to be used with TweenService.
local function Tween(Object, Props, Modifiers)
	local Modifiers, Tween = Modifiers or {}, nil
	Modifiers.T = Modifiers.T or Modifiers.Time or .25 -- Time
	Modifiers.ES = Modifiers.ES or Modifiers.EasingStyle -- EasingStyle
	Modifiers.ES = Modifiers.ES and (Enum.EasingStyle[Modifiers.ES] or Modifiers.ES) or Enum.EasingStyle.Quart
	Modifiers.ED = Modifiers.ED or Modifiers.EasingDirection -- EasingDirection
	Modifiers.ED = Modifiers.ED and (Enum.EasingDirection[Modifiers.ED] or Modifiers.ED) or Enum.EasingDirection.Out
	Modifiers.RC = Modifiers.RC or Modifiers.RepeatCount or 0 -- RepeatCount
	Modifiers.R = Modifiers.R or Modifiers.Repeat or false -- Repeat
	Modifiers.DT = Modifiers.DT or Modifiers.DelayTime or 0 -- DelayTime
	Modifiers.CB = Modifiers.CB or Modifiers.Callback or false -- Callback
	local Return = Pure(Object, Props, Modifiers)
	if Modifiers.AP == true or Modifiers.AP == nil then
		Return:Play() -- AutoPlay
	end
	return Return
end

-- Object for handling groupped tweens.
local T = {}
T.__index = T
function T.new(Data) return setmetatable({Data = Data, Completed = Data[1].Completed}, T) end
function T:Cancel() for Index, TN in pairs(self.Data) do TN:Cancel() end end
function T:Pause() for Index, TN in pairs(self.Data) do TN:Pause() end end
function T:Play() for Index, TN in pairs(self.Data) do TN:Play() end end

-- This is used for inputs that are not applicable to TweenService tweens.
local function UnPure(Object, Props, Modifiers)
	Modifiers.T = Modifiers.T or Modifiers.Time or .25 -- Time
	Modifiers.ES = (Modifiers.ED or Modifiers.EasingDirection or 'Out') .. (Modifiers.ES or Modifiers.EasingStyle or 'Quart') -- EasingStyle
	Modifiers.AP = Modifiers.AP or true -- AutoPlay
	Modifiers.Completed = Modifiers.CB or Modifiers.Callback or function() end
	Modifiers.OnUpdate = Modifiers.OnUpdate or function() end
	Modifiers.CB = function(Data)
		for Index, Value in pairs(Data) do
			Object[Index] = Value
		end
		Modifiers.OnUpdate()
	end
	local Timed = Timers.new(Object, Props, Modifiers)
	if Modifiers.OnUpdate then
		Timed.OnUpdate = Modifiers.OnUpdate
	end
	if Modifiers.AP == true or Modifiers.AP == nil then
		Timed:Play()
	end
	return Timed
end

-- Exposed Tween function.
return function(...)
	local Params = {...}
	local Success, Message = pcall(function()
		assert(Params[1], 'No parameters provided!')
		if typeof(Params[1]) == 'Instance' then -- This is a regular tween!
			assert(Params[2], 'Properties dictionary not defined!')
			return Tween(Params[1], Params[2], Params[3])
		elseif typeof(Params[1]) == 'table' then -- This is something else!
			local Class, IndexClass
			for Index, Item in pairs(Params[1]) do
				IndexClass = typeof(Index)
				Class = typeof(Item)
				break
			end
			if Class == 'Instance' then -- This is a list of objects!
				assert(Params[2], 'Properties dictionary not defined!')
				local Tweens = {}
				for Index, Item in pairs(Params[1]) do
					table.insert(Tweens, 1, Tween(Item, Params[2], Params[3]))
				end
				return T.new(Tweens)
			else
				if IndexClass == 'string' then -- This is a dictionary of values!
					assert(Params[2], 'Properties dictionary not defined!')
					return UnPure(Params[1], Params[2], Params[3])
				end
				error('Invalid parameters used!') -- At this point, you're going a bit too far, buddy.
			end
		end
	end)
	if Success then
		return Message
	end
	warn(Message)
end

