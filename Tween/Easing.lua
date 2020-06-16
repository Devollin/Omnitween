local Tween = {
	_VERSION		 = 'Tween 2.1.1',
	_DESCRIPTION = 'Tweening for lua',
	_URL				 = 'https://github.com/kikito/tween.lua',
	_LICENSE		 = [[
		MIT LICENSE
		Copyright (c) 2014 Enrique García Cota, Yuichi Tateno, Emmanuel Oga
		Permission is hereby granted, free of charge, to any person obtaining a
		copy of this software and associated documentation files (the
		"Software"), to deal in the Software without restriction, including
		without limitation the rights to use, copy, modify, merge, publish,
		distribute, sublicense, and/or sell copies of the Software, and to
		permit persons to whom the Software is furnished to do so, subject to
		the following conditions:
		The above copyright notice and this permission notice shall be included
		in all copies or substantial portions of the Software.
		THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
		OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
		MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
		IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
		CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
		TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
		SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
	]]
}

-- Adapted from https://github.com/EmmanuelOga/easing. See LICENSE.txt for credits.
-- For all easing functions:
-- t = time == how much time has to pass for the tweening to complete
-- b = begin == starting property value
-- c = change == ending - beginning
-- d = duration == running time. How much time has passed *right now*

-- easing

local EasingStyles = {}

local Pow, Sin, Cos, Pi, Sqrt, Abs, Asin = math.pow, math.sin, math.cos, math.pi, math.sqrt, math.abs, math.asin

-- linear
function EasingStyles.Linear(T, B, C, D) 
	return C * T / D + B 
end


-- quad
function EasingStyles.InQuad(T, B, C, D) 
	return C * Pow(T / D, 2) + B 
end

function EasingStyles.OutQuad(T, B, C, D)
	T = T / D
	return -C * T * (T - 2) + B
end

function EasingStyles.InOutQuad(T, B, C, D)
	T = T / D * 2
	if T < 1 then 
		return C / 2 * Pow(T, 2) + B 
	end
	return -C / 2 * ((T - 1) * (T - 3) - 1) + B
end

function EasingStyles.OutInQuad(T, B, C, D)
	if T < D / 2 then 
		return EasingStyles.OutQuad(T * 2, B, C / 2, D) 
	end
	return EasingStyles.InQuad((T * 2) - D, B + C / 2, C / 2, D)
end


-- cubic
function EasingStyles.InCubic (T, B, C, D) 
	return C * Pow(T / D, 3) + B 
end

function EasingStyles.OutCubic(T, B, C, D) 
	return C * (Pow(T / D - 1, 3) + 1) + B 
end

function EasingStyles.InOutCubic(T, B, C, D)
	T = T / D * 2
	if T < 1 then 
		return C / 2 * T * T * T + B 
	end
	T = T - 2
	return C / 2 * (T * T * T + 2) + B
end

function EasingStyles.OutInCubic(T, B, C, D)
	if T < D / 2 then 
		return EasingStyles.OutCubic(T * 2, B, C / 2, D) 
	end
	return EasingStyles.InCubic((T * 2) - D, B + C / 2, C / 2, D)
end


-- quart
function EasingStyles.InQuart(T, B, C, D) 
	return C * Pow(T / D, 4) + B 
end

function EasingStyles.OutQuart(T, B, C, D) 
	return -C * (Pow(T / D - 1, 4) - 1) + B 
end

function EasingStyles.InOutQuart(T, B, C, D)
	T = T / D * 2
	if T < 1 then 
		return C / 2 * Pow(T, 4) + B 
	end
	return -C / 2 * (Pow(T - 2, 4) - 2) + B
end

function EasingStyles.OutInQuart(T, B, C, D)
	if T < D / 2 then 
		return EasingStyles.OutQuart(T * 2, B, C / 2, D) 
	end
	return EasingStyles.InQuart((T * 2) - D, B + C / 2, C / 2, D)
end


-- quint
function EasingStyles.InQuint(T, B, C, D) 
	return C * Pow(T / D, 5) + B 
end

function EasingStyles.OutQuint(T, B, C, D) 
	return C * (Pow(T / D - 1, 5) + 1) + B 
end

function EasingStyles.InOutQuint(T, B, C, D)
	T = T / D * 2
	if T < 1 then 
		return C / 2 * Pow(T, 5) + B 
	end
	return C / 2 * (Pow(T - 2, 5) + 2) + B
end

function EasingStyles.OutInQuint(T, B, C, D)
	if T < D / 2 then 
		return EasingStyles.OutQuint(T * 2, B, C / 2, D) 
	end
	return EasingStyles.InQuint((T * 2) - D, B + C / 2, C / 2, D)
end


-- sine
function EasingStyles.InSine(T, B, C, D) 
	return -C * Cos(T / D * (Pi / 2)) + C + B 
end

function EasingStyles.OutSine(T, B, C, D) 
	return C * Sin(T / D * (Pi / 2)) + B 
end

function EasingStyles.InOutSine(T, B, C, D) 
	return -C / 2 * (Cos(Pi * T / D) - 1) + B 
end

function EasingStyles.OutInSine(T, B, C, D)
	if T < D / 2 then 
		return EasingStyles.OutSine(T * 2, B, C / 2, D) 
	end
	return EasingStyles.InSine((T * 2) -D, B + C / 2, C / 2, D)
end


-- expo
function EasingStyles.InExpo(T, B, C, D)
	if T == 0 then 
		return B 
	end
	return C * Pow(2, 10 * (T / D - 1)) + B - C * 0.001
end

function EasingStyles.OutExpo(T, B, C, D)
	if T == D then 
		return B + C 
	end
	return C * 1.001 * (-Pow(2, -10 * T / D) + 1) + B
end

function EasingStyles.InOutExpo(T, B, C, D)
	if T == 0 then 
		return B 
	end
	if T == D then 
		return B + C 
	end
	T = T / D * 2
	if T < 1 then 
		return C / 2 * Pow(2, 10 * (T - 1)) + B - C * 0.0005 
	end
	return C / 2 * 1.0005 * (-Pow(2, -10 * (T - 1)) + 2) + B
end

function EasingStyles.OutInExpo(T, B, C, D)
	if T < D / 2 then 
		return EasingStyles.OutExpo(T * 2, B, C / 2, D) 
	end
	return EasingStyles.InExpo((T * 2) - D, B + C / 2, C / 2, D)
end

-- circ
function EasingStyles.InCirc(T, B, C, D) 
	return(-C * (Sqrt(1 - Pow(T / D, 2)) - 1) + B) 
end

function EasingStyles.OutCirc(T, B, C, D)	
	return(C * Sqrt(1 - Pow(T / D - 1, 2)) + B) 
end

function EasingStyles.InOutCirc(T, B, C, D)
	T = T / D * 2
	if T < 1 then 
		return -C / 2 * (Sqrt(1 - T * T) - 1) + B 
	end
	T = T - 2
	return C / 2 * (Sqrt(1 - T * T) + 1) + B
end

function EasingStyles.OutInCirc(T, B, C, D)
	if T < D / 2 then 
		return EasingStyles.OutCirc(T * 2, B, C / 2, D) 
	end
	return EasingStyles.InCirc((T * 2) - D, B + C / 2, C / 2, D)
end


-- elastic
function EasingStyles.CalculatePAS(P,A,C,D)
	P, A = P or D * 0.3, A or 0
	if A < Abs(C) then 
		return P, C, P / 4 
	end -- p, a, s
	return P, A, P / (2 * Pi) * Asin(C/A) -- p,a,s
end

function EasingStyles.InElastic(T, B, C, D, A, P)
	local S
	if T == 0 then 
		return B 
	end
	T = T / D
	if T == 1 then 
		return B + C 
	end
	P,A,S = EasingStyles.CalculatePAS(P,A,C,D)
	T = T - 1
	return -(A * Pow(2, 10 * T) * Sin((T * D - S) * (2 * Pi) / P)) + B
end

function EasingStyles.OutElastic(T, B, C, D, A, P)
	local S
	if T == 0 then 
		return B 
	end
	T = T / D
	if T == 1 then 
		return B + C 
	end
	P,A,S = EasingStyles.CalculatePAS(P,A,C,D)
	return A * Pow(2, -10 * T) * Sin((T * D - S) * (2 * Pi) / P) + C + B
end

function EasingStyles.InOutElastic(T, B, C, D, A, P)
	local S
	if T == 0 then 
		return B 
	end
	T = T / D * 2
	if T == 2 then 
		return B + C 
	end
	P,A,S = EasingStyles.CalculatePAS(P,A,C,D)
	T = T - 1
	if T < 0 then 
		return -0.5 * (A * Pow(2, 10 * T) * Sin((T * D - S) * (2 * Pi) / P)) + B 
	end
	return A * Pow(2, -10 * T) * Sin((T * D - S) * (2 * Pi) / P ) * 0.5 + C + B
end

function EasingStyles.OutInElastic(T, B, C, D, A, P)
	if T < D / 2 then 
		return EasingStyles.OutElastic(T * 2, B, C / 2, D, A, P) 
	end
	return EasingStyles.InElastic((T * 2) - D, B + C / 2, C / 2, D, A, P)
end


-- back
function EasingStyles.InBack(T, B, C, D, S)
	S = S or 1.70158
	T = T / D
	return C * T * T * ((S + 1) * T - S) + B
end

function EasingStyles.OutBack(T, B, C, D, S)
	S = S or 1.70158
	T = T / D - 1
	return C * (T * T * ((S + 1) * T + S) + 1) + B
end

function EasingStyles.InOutBack(T, B, C, D, S)
	S = (S or 1.70158) * 1.525
	T = T / D * 2
	if T < 1 then 
		return C / 2 * (T * T * ((S + 1) * T - S)) + B 
	end
	T = T - 2
	return C / 2 * (T * T * ((S + 1) * T + S) + 2) + B
end

function EasingStyles.OutInBack(T, B, C, D, S)
	if T < D / 2 then 
		return EasingStyles.OutBack(T * 2, B, C / 2, D, S) 
	end
	return EasingStyles.InBack((T * 2) - D, B + C / 2, C / 2, D, S)
end


-- bounce
function EasingStyles.OutBounce(T, B, C, D)
	T = T / D
	if T < 1 / 2.75 then 
		return C * (7.5625 * T * T) + B 
	end
	if T < 2 / 2.75 then
		T = T - (1.5 / 2.75)
		return C * (7.5625 * T * T + 0.75) + B
	elseif T < 2.5 / 2.75 then
		T = T - (2.25 / 2.75)
		return C * (7.5625 * T * T + 0.9375) + B
	end
	T = T - (2.625 / 2.75)
	return C * (7.5625 * T * T + 0.984375) + B
end
	
function EasingStyles.InBounce(T, B, C, D) 
	return C - EasingStyles.OutBounce(D - T, 0, C, D) + B 
end

function EasingStyles.InOutBounce(T, B, C, D)
	if T < D / 2 then 
		return EasingStyles.InBounce(T * 2, 0, C, D) * 0.5 + B 
	end
	return EasingStyles.OutBounce(T * 2 - D, 0, C, D) * 0.5 + C * .5 + B
end

function EasingStyles.OutInBounce(T, B, C, D)
	if T < D / 2 then 
		return EasingStyles.OutBounce(T * 2, B, C / 2, D) 
	end
	return EasingStyles.InBounce((T * 2) - D, B + C / 2, C / 2, D)
end

Tween.EasingStyles = EasingStyles

-- private stuff

local function CopyTables(Destination, KeysTable, ValuesTable)
	ValuesTable = ValuesTable or KeysTable
	local MT = getmetatable(KeysTable)
	if MT and getmetatable(Destination) == nil then
		setmetatable(Destination, MT)
	end
	for K, V in pairs(KeysTable) do
		if type(V) == 'table' then
			Destination[K] = CopyTables({}, V, ValuesTable[K])
		else
			Destination[K] = ValuesTable[K]
		end
	end
	return Destination
end

local function CheckSubjectAndTargetRecursively(Subject, Target, Path)
	Path = Path or {}
	local TargetType, NewPath
	for K, TargetValue in pairs(Target) do
		TargetType, NewPath = type(TargetValue), CopyTables({}, Path)
		table.insert(NewPath, tostring(K))
		if TargetType == 'number' then
			assert(type(Subject[K]) == 'number', "Parameter '" .. table.concat(NewPath,'/') .. "' is missing from Subject or isn't a number")
		elseif TargetType == 'table' then
			CheckSubjectAndTargetRecursively(Subject[K], TargetValue, NewPath)
		else
			assert(TargetType == 'number', "Parameter '" .. table.concat(NewPath,'/') .. "' must be a number or table of numbers")
		end
	end
end

local function CheckNewParams(Duration, Subject, Target, Easing)
	assert(type(Duration) == 'number' and Duration > 0, "Duration must be a positive number. Was " .. tostring(Duration))
	local TSubject = type(Subject)
	assert(TSubject == 'table' or TSubject == 'userdata', "Subject must be a table or userdata. Was " .. tostring(Subject))
	assert(type(Target)== 'table', "Target must be a table. Was " .. tostring(Target))
	assert(type(Easing)=='function', "Easing must be a function. Was " .. tostring(Easing))
	CheckSubjectAndTargetRecursively(Subject, Target)
end

local function GetEasingFunction(Easing)
	Easing = Easing or "linear"
	if type(Easing) == 'string' then
		local Name = Easing
		Easing = Tween.EasingStyles[Name]
		if type(Easing) ~= 'function' then
			error("The Easing function Name '" .. Name .. "' is invalid")
		end
	end
	return Easing
end

local function PerformEasingOnSubject(Subject, Target, Initial, Clock, Duration, Easing)
	local T, B, C, D
	for K, V in pairs(Target) do
		if type(V) == 'table' then
			PerformEasingOnSubject(Subject[K], V, Initial[K], Clock, Duration, Easing)
		else
			T, B, C, D = Clock, Initial[K], V - Initial[K], Duration
			Subject[K] = Easing(T, B, C, D)
		end
	end
end

-- Tween methods

local Tween = {}
local Tween_MT = {__index = Tween}

function Tween:Set(Clock)
	assert(type(Clock) == 'number', "Clock must be a positive number or 0")

	self.Initial = self.Initial or CopyTables({}, self.Target, self.Subject)
	self.Clock = Clock

	if self.Clock <= 0 then

		self.Clock = 0
		CopyTables(self.Subject, self.Initial)

	elseif self.Clock >= self.Duration then -- the tween has expired

		self.Clock = self.Duration
		CopyTables(self.Subject, self.Target)

	else

		PerformEasingOnSubject(self.Subject, self.Target, self.Initial, self.Clock, self.Duration, self.Easing)

	end

	return self.Clock >= self.Duration
end

function Tween:Reset()
	return self:Set(0)
end

function Tween:Update(dt)
	assert(type(dt) == 'number', "dt must be a number")
	return self:Set(self.Clock + dt)
end


-- Public interface

function Tween.new(Duration, Subject, Target, Easing)
	Easing = GetEasingFunction(Easing)
	CheckNewParams(Duration, Subject, Target, Easing)
	return setmetatable({
		Duration = Duration,
		Subject = Subject,
		Target = Target,
		Easing = Easing,
		Clock = 0
	}, Tween_MT)
end

return Tween
