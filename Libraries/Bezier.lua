local Bezier = {}

Bezier.__index = Bezier

local function Lerp(A, B, C)
	return A + (B - A) * C
end

function Bezier:BuildPath(CP)
	local Points = {}
	for Index = 1, self.Vectors - 1 do
		Points[Index] = Lerp(self.Vectors[Index], self.Vectors[Index + 1], CP)
	end
	if #Points >= 3 then
		return Bezier.BuildPath(Points, CP)
	end
	return Lerp(Points[1], Points[2], CP)
end

function Bezier:Reverse()
	self.Data.Reverse = not self.Data.Reverse
	self.Data.Time = 1 - self.Data.Time
	
end

function Bezier:Stop()
	
end

function Bezier:Play()
	for Step = 1, self.Data.Length * self.Data.StepsPerSecond do
		
	end
end

function Bezier:Iterate()
	
end

function Bezier:FixedCurve()
	
end

function Bezier.new(Vectors, Data)
	assert(Vectors ~= nil, 'No variables were given!')
	assert(typeof(Vectors) == 'table', 'Vectors is not a table!')
	local self = {}
	setmetatable(self, Bezier)
	Data = Data or {}
	Data.Vectors = Vectors
	Data.StepsPerSecond = Data.StepsPerSecond or 60
	Data.Length = Data.Length or 1
	Data.Time = Data.Time or 0
	Data.Classic = Data.Classic or true -- When true, time is the percentage of distance
	Data.Smooth = Data.Smooth or true
	Data.Reverse = Data.Reverse or false
	self.Data = Data
	
	return self
end

return Bezier
