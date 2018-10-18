local Checks = require(script.Checks)
local Config = require(script.Config)
local Native = require(script.NativeHandler)
local Bezier = require(script.Bezier)
local Complex = require(script.ComplexTypeHandler)
local TweenFunctions = require(script.TweenFunctions)

local function Tween(Objects, Properties, Data)
	local Tweens
	local Defaults = Config.Defaults -- Gets a table of Default tween settings.
	local Good, Message = Checks.PreTween(Objects, Properties) -- Returns true if the basic requirements are fufilled. If not, then it returns Message.
	
	if not Good then
		warn(Message) -- Sends the warning message.
		return -- Stops the tween function here if Good was false.
	end
	
	Properties = Checks.CheckForBezier(Properties) -- Splits Properties into two tables: Bezier and Not.
	Data = Data or {} -- Makes sure that Data is not nil.
	
	for Index, Info in pairs(Data) do -- Iterates over Data.
		Defaults[Index] = Info -- Settings are put into the Default. (temporarily)
	end
		
	Data = Defaults -- Data is now fully defined.
	
	do
		local Result, Message = Checks.DetermineType(Objects) -- Result : string returned by typeof(Objects), and Message : string returned by error or if Object is a table, returns the typeof string for the value.
		
		if Result == 'Instance' then
			
			Tweens = Native(Objects, Properties.Not, Data) -- Creates the tween object.
			if Data.AP then
				if Data.D then
					wait(Data.D)
				end
				Tweens:Play() -- If AutoPlay (Data.AP) is true, then this tween will play.
			end
			
			if Properties.Bezier and Properties.Bezier ~= {} then -- TODO: MAKE COMPLEX MODULE WORK TO ENABLE BEZIER CURVES ON PROPERTIES
				local TSteps = math.floor((60 * Data.T) + 0.5)
				for T = 1, TSteps do
					for Index, Prop in pairs(Properties.Bezier) do
						Bezier.BuildPath(Prop, T / TSteps)
					end
					wait()
				end
			end
			
		elseif Result == 'table' then
			Tweens = {}
			if Message == 'Instance' then
				for Index, Item in pairs(Objects) do
					
					local Tweened = Native(Item, Properties.Not, Data) -- Creates the tween object.
					table.insert(Tweens, 1, Tweened)
					if Data.AP then
						Tweened:Play() -- If AutoPlay (Data.AP) is true, then this tween will play.
					end
					
				end
			else
				-- TODO : NUMBER/ANY OTHER DATA TWEEN GOES HERE
			end
		elseif Result == 'error' then -- If an unsupported Type is found, then this will print a warn and stop the tween.
			warn(Message)
			return
			
		end
	end
	
	return {}
end

return function(...)
	local Data = {...}
	if Checks.AnimationOrTween(...) then
		local TweenS = {}
		for Index = 1, #Data do
			TweenS[Index] = Tween(Data[Index][1], Data[Index][2], (Data[Index][3] and Data[Index][3]) or nil)
		end
		return TweenS
	end
	return Tween(Data[1], Data[2], Data[3] and Data[3] or nil)
end
