-- Created by EgoMoose
-- URL : https://devforum.roblox.com/t/reparameterization-tips-and-tricks/135935
-- Adjusted for Omnitween

local function FixedBezier(Time, A, B, C)
    return (1 - Time)^2 * A + 2 * (1 - Time) * Time * B + Time^2 * C
end

local function Simpson(Function, VarA, VarB, Number)
    if (Number % 2 ~= 0) then
        return
    end
    local H = (VarB - VarA) / Number
    local S = Function(VarA) + Function(VarB)
    for Index = 1, Number, 2 do
        S = S + 4 * Function(VarA + Index * H)
    end
    for Index = 2, Number-1, 2 do
        S = S + 2 * Function(VarA + Index * H)
    end
    return S * (H / 3)
end

return function(Time, A, B, C, Number)
    local function ArcLength(Time)
        local VarA = A - 2*B + C
        local VarB = 2 * (B - A)
        local A = 4 * VarA:Dot(VarA)
        local B = 4 * VarA:Dot(VarB)
        local C = VarB:Dot(VarB)
        return math.sqrt(A * Time * Time + B * Time + C)
    end

    local Number = Number or 16
    local Length = Simpson(ArcLength, 0, 1, Number)
	if not Length then
		return
	end
    local Distance = Time * Length

    for Index = 1, 5 do
        Time = Time - (Simpson(ArcLength, 0, Time, Number) - Distance) / ArcLength(Time)
    end

    return FixedBezier(Time, A, B, C)
end
