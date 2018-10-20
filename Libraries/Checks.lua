local Checks = {}

function Checks.PreTween(Objects, Properties) -- Checks to be sure that the tween will not error for insufficient requirements.
	local Good, Message = pcall(function() -- Only used to catch errors.
		
		-- These will throw errors if the requirements are not fufilled, but the pcall wrapping these will make it return the error and put a warn in the output from the parent module.
		assert(Objects and true, 'No variables were given!') -- Makes sure that the function has arguments.
		assert(Properties, 'No properties were given!') -- Makes sure that there are Properties to tween.
		assert(typeof(Properties) == 'table', 'Properties is not a table!') -- Makes sure that Properties is not any other DataType except for a table.
		
		local Count = 0
		for _, _ in pairs(Properties) do
			Count = Count + 1
		end
		
		assert(Count > 0, 'No properties to tween!') -- Makes sure that there are Properties to tween in the table.
		
	end)
	return Good, Message
end


function Checks.AnimationOrTween(...) -- Checks if the arguments are tables with tween info in them (animation), or if they are just a regular tween function call
	local Args = {...}
	if typeof(Args[1]) == 'table' and #Args[1] >= 2 and (typeof(Args[1][1]) == 'table' or typeof(Args[1][1]) == 'Instance') then
		return true -- Animation
	end
	return false -- Tween
end


function Checks.DetermineType(Objects) -- Determines the Type of Objects, whether it is a table or an Instance.
	local Type = typeof(Objects) -- Holds a string of the DataType of the Objects.
	
	if Type == 'table' then -- Is the Object a table?
		
		for Index, Value in pairs(Objects) do -- Does a single check here to see if the items on this table are Instances or number values.
			local VType = type(Value)
			
			if VType == 'Instance' or VType == 'number' then -- Is the Value an Instance or a number?
				return Type, VType -- Returns the DataType of the Value
				
			end
			return 'error', 'Unsupported type found!' -- If an unsupported DataType is put as an Argument, this will be thrown as a warning.

		end
	elseif Type == 'Instance' then -- Is the Object an Instance?
		return Type -- Returns 'Instance'.
		
	end
	
	return 'error', 'Unsupported type found!' -- If an unsupported DataType is put as an Argument, this will be thrown as a warning.
end


function Checks.SeparateTypes(Properties) -- Separates by tween type.
	local ReturnTable = {Not = {}} -- Holds two tables, one for for Bezier tweens, and the other for regular tweens.
	
	for Index, Goal in pairs(Properties) do -- Iterates over Properties.
		
		if type(Goal) == 'table' then -- Is the Goal for a Property is a table?
			if type(Goal[1]) == 'table' then -- Checks to see if this is a sequence or a bezier tween.
				if not ReturnTable.Sequence then
					ReturnTable.Sequence = {}
				end
				
				ReturnTable.Sequence[Index] = Goal
				
			else
				if not ReturnTable.Bezier then
					ReturnTable.Bezier = {}
				end
				
				ReturnTable.Bezier[Index] = Goal -- Inserts the Goal onto the Bezier table.
				
			end
		else -- If the Goal is not a table, then it is a regular tween.
			
			ReturnTable.Not[Index] = Goal -- Inserts the Goal onto the Not table.
			
		end
	end
	
	return ReturnTable -- Returns the tables for use.
end

return Checks
