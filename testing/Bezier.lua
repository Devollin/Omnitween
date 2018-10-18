local Bezier = {}

local function Lerp(A, B, C)
	return A + (B - A) * C
end

function Bezier.BuildPath(Vectors, CP)
	local Points = {}
	for Index = 1, #Vectors - 1 do
		Points[Index] = Lerp(Vectors[Index], Vectors[Index + 1], CP)
	end
	if #Points >= 3 then
		return Bezier.BuildPath(Points, CP)
	end
	return Lerp(Points[1], Points[2], CP)
end

function Bezier.Curve(Vectors, T, S)
	local Data = {
		Pause = false,
		Duration = T,
		Steps = S,
		Step = 0, 
		TimePos = 0
	}
	local Curve = {
		
		Play = function()
			Data.Pause = false
			repeat
				Bezier.BuildPath(Vectors, S)
				wait(T / S)
			until Data.Pause or Data.TimePos == 1
		end,
		
		Pause = function()
			Data.Pause = true
		end,
		
		Stop = function()
			Data.Pause = true
			Data.Step = 0
			Data.TimePos = 0
		end
		
	}
	Curve.Data = Data
	return Curve
end

return Bezier
