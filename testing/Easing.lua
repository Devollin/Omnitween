local tween = {
	_VERSION		 = 'tween 2.1.1',
	_DESCRIPTION = 'tweening for lua',
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

-- easing

tween.EasingStyles = require(script.Parent.EasingStyles)

-- private stuff

local function copyTables(destination, keysTable, valuesTable)
	valuesTable = valuesTable or keysTable
	local mt = getmetatable(keysTable)
	if mt and getmetatable(destination) == nil then
		setmetatable(destination, mt)
	end
	for k,v in pairs(keysTable) do
		if type(v) == 'table' then
			destination[k] = copyTables({}, v, valuesTable[k])
		else
			destination[k] = valuesTable[k]
		end
	end
	return destination
end

local function checkSubjectAndTargetRecursively(subject, target, path)
	path = path or {}
	local targetType, newPath
	for k,targetValue in pairs(target) do
		targetType, newPath = type(targetValue), copyTables({}, path)
		table.insert(newPath, tostring(k))
		if targetType == 'number' then
			assert(type(subject[k]) == 'number', "Parameter '" .. table.concat(newPath,'/') .. "' is missing from subject or isn't a number")
		elseif targetType == 'table' then
			checkSubjectAndTargetRecursively(subject[k], targetValue, newPath)
		else
			assert(targetType == 'number', "Parameter '" .. table.concat(newPath,'/') .. "' must be a number or table of numbers")
		end
	end
end

local function checkNewParams(duration, subject, target, easing)
	assert(type(duration) == 'number' and duration > 0, "duration must be a positive number. Was " .. tostring(duration))
	local tsubject = type(subject)
	assert(tsubject == 'table' or tsubject == 'userdata', "subject must be a table or userdata. Was " .. tostring(subject))
	assert(type(target)== 'table', "target must be a table. Was " .. tostring(target))
	assert(type(easing)=='function', "easing must be a function. Was " .. tostring(easing))
	checkSubjectAndTargetRecursively(subject, target)
end

local function getEasingFunction(easing)
	easing = easing or "linear"
	if type(easing) == 'string' then
		local name = easing
		easing = tween.EasingStyles[name]
		if type(easing) ~= 'function' then
			error("The easing function name '" .. name .. "' is invalid")
		end
	end
	return easing
end

local function performEasingOnSubject(subject, target, initial, clock, duration, easing)
	local t,b,c,d
	for k,v in pairs(target) do
		if type(v) == 'table' then
			performEasingOnSubject(subject[k], v, initial[k], clock, duration, easing)
		else
			t,b,c,d = clock, initial[k], v - initial[k], duration
			subject[k] = easing(t,b,c,d)
		end
	end
end

-- Tween methods

local Tween = {}
local Tween_mt = {__index = Tween}

function Tween:Set(clock)
	assert(type(clock) == 'number', "clock must be a positive number or 0")

	self.initial = self.initial or copyTables({}, self.target, self.subject)
	self.clock = clock

	if self.clock <= 0 then

		self.clock = 0
		copyTables(self.subject, self.initial)

	elseif self.clock >= self.duration then -- the tween has expired

		self.clock = self.duration
		copyTables(self.subject, self.target)

	else

		performEasingOnSubject(self.subject, self.target, self.initial, self.clock, self.duration, self.easing)

	end

	return self.clock >= self.duration
end

function Tween:Reset()
	return self:set(0)
end

function Tween:Update(dt)
	assert(type(dt) == 'number', "dt must be a number")
	return self:Set(self.clock + dt)
end


-- Public interface

function tween.new(duration, subject, target, easing)
	easing = getEasingFunction(easing)
	checkNewParams(duration, subject, target, easing)
	return setmetatable({
		duration = duration,
		subject = subject,
		target = target,
		easing = easing,
		clock = 0
	}, Tween_mt)
end

return tween
