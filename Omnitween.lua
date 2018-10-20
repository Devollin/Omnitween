local Checks = require(script.Checks)
local Config = require(script.Config)
local Bezier = require(script.Bezier)
local Reconstructor = require(script.Reconstructor)
local TweenFunctions = {}

function TweenFunctions.Play(Tweens)
	
end

function TweenFunctions.Replay(Tweens)
	
end

function TweenFunctions.Pause(Tweens)
	
end

function TweenFunctions.Stop(Tweens)
	
end

function TweenFunctions.Reverse(Tweens)
	
end

local function Native(Object, Properties, Data)
	return Config.TweenService:Create(Object, TweenInfo.new(Data.T, Data.ES, Data.ED, Data.RC, Data.R, Data.DT), Properties)
end

local function SetProperties(Objects, SetTo)
	for Index, Object in ipairs(Objects) do
		for Name, Value in pairs(SetTo) do
			Object[Name] = Value
		end
	end
end

local function Tween(Objects, Properties, Data)
	local Tweens
	local Defaults = Config.Defaults -- Gets a table of Default tween settings.
	local Good, Message = Checks.PreTween(Objects, Properties) -- Returns true if the basic requirements are fufilled. If not, then it returns Message.
	
	if not Good then
		warn(Message) -- Sends the warning message.
		return -- Stops the tween function here if Good was false.
	end
	
	Properties = Checks.SeparateTypes(Properties) -- Splits Properties into two tables: Bezier and Not.local Checks = require(script.Checks)
local Config = require(script.Config)
local Bezier = require(script.Bezier)
local Reconstructor = require(script.Reconstructor)
local TweenFunctions = {}

function TweenFunctions.Play(Tweens)
	
end

function TweenFunctions.Replay(Tweens)
	
end

function TweenFunctions.Pause(Tweens)
	
end

function TweenFunctions.Stop(Tweens)
	
end

function TweenFunctions.Reverse(Tweens)
	
end

local function Native(Object, Properties, Data)
	return Config.TweenService:Create(Object, TweenInfo.new(Data.T, Data.ES, Data.ED, Data.RC, Data.R, Data.DT), Properties)
end

local function SetProperties(Objects, SetTo)
	for Index, Object in ipairs(Objects) do
		for Name, Value in pairs(SetTo) do
			Object[Name] = Value
		end
	end
end

local function Tween(Objects, Properties, Data)
	local Tweens
	local Defaults = Config.Defaults -- Gets a table of Default tween settings.
	local Good, Message = Checks.PreTween(Objects, Properties) -- Returns true if the basic requirements are fufilled. If not, then it returns Message.
	
	if not Good then
		warn(Message) -- Sends the warning message.
		return -- Stops the tween function here if Good was false.
	end
	
	Properties = Checks.SeparateTypes(Properties) -- Splits Properties into two tables: Bezier and Not.
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
			
			if Properties.Bezier and Properties.Bezier ~= {} then -- TODO: MAKE RECONSTRUCTOR MODULE WORK TO ENABLE BEZIER CURVES ON PROPERTIES
				
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
			else -- TODO : CONTINUE WORK ON NUMBER TWEENING
				
				local Assist = {A = 0}
				local Types = {Color3 = true, CFrame = true, UDim2 = true, Vector2 = true, Vector3 = true, }
				
				for Ind, Item in ipairs(Properties) do
					spawn(function() 
						for Ind2 = 1, Data.T * Data.SPS do 
							Config.Easing.new(Data.T, Assist, {Val = 1}, tostring(Data.ED.Name..Data.ES.Name)):Update(Data.SPS) 
							wait(Data.SPS) 
						end 
					end)
					if Types[typeof(Item[2])] then
						
							for Ind2 = 1, Data.T * Data.SPS do 
								Object[Item[1]] = Object[Item[1]]:Lerp(Item[2], Assist.Val) 
								wait(Data.T / Data.SPS) 
							end 
						
					else
						
							for Ind2 = 1, Data.T * Data.SPS do 
								
								Config.Easing.new(Data.T, Object, {[Item[1]] = Item[2]}, tostring(Data.ED.Name..Data.ES.Name)):Update(Data.SPS) 
								wait(Data.SPS) 
							end 
						
					end
				end
		
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
	if #Data == 0 then
		return Config.Easing, Config.Easing.EasingStyles
	end
	if Checks.AnimationOrTween(...) then
		local TweenS = {}
		for Index = 1, #Data do
			TweenS[Index] = Tween(Data[Index][1], Data[Index][2], (Data[Index][3] and Data[Index][3]) or nil)
		end
		return TweenS
	end
	return Tween(Data[1], Data[2], Data[3] and Data[3] or nil)
end
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
			
			if Properties.Bezier and Properties.Bezier ~= {} then -- TODO: MAKE RECONSTRUCTOR MODULE WORK TO ENABLE BEZIER CURVES ON PROPERTIES
				
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
			else -- TODO : CONTINUE WORK ON NUMBER TWEENING
				
				local Assist = {A = 0}
				local Types = {Color3 = true, CFrame = true, UDim2 = true, Vector2 = true, Vector3 = true, }
				
				for Ind, Item in ipairs(Properties) do
					spawn(function() 
						for Ind2 = 1, Data.T * Data.SPS do 
							Config.Easing.new(Data.T, Assist, {Val = 1}, tostring(Data.ED.Name..Data.ES.Name)):Update(Data.SPS) 
							wait(Data.SPS) 
						end 
					end)
					if Types[typeof(Item[2])] then
						
							for Ind2 = 1, Data.T * Data.SPS do 
								Object[Item[1]] = Object[Item[1]]:Lerp(Item[2], Assist.Val) 
								wait(Data.T / Data.SPS) 
							end 
						
					else
						
							for Ind2 = 1, Data.T * Data.SPS do 
								
								Config.Easing.new(Data.T, Object, {[Item[1]] = Item[2]}, tostring(Data.ED.Name..Data.ES.Name)):Update(Data.SPS) 
								wait(Data.SPS) 
							end 
						
					end
				end
		
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
	if #Data == 0 then
		return Config.Easing
	end
	if Checks.AnimationOrTween(...) then
		local TweenS = {}
		for Index = 1, #Data do
			TweenS[Index] = Tween(Data[Index][1], Data[Index][2], (Data[Index][3] and Data[Index][3]) or nil)
		end
		return TweenS
	end
	return Tween(Data[1], Data[2], Data[3] and Data[3] or nil)
end
