local Easing = require(script.Easing)
local Types = {{["Instance"] = true}, {["Color3"] = true, ["CFrame"] = true, ["UDim2"] = true, ["Vector2"] = true, ["Vector3"] = true}}

function Tween(Object, Properties, D)
	assert(Object and Properties and typeof(Properties) == "table", "Insufficient values, cancelling Tween!")
	local D, Assist, Tween = D or {}, {Val = 0}
	D.T = D.T or .25 -- Time
	D.ES = D.ES or Enum.EasingStyle.Quart -- EasingStyle
	D.ED = D.ED or Enum.EasingDirection.Out -- EasingDirection
	if (typeof(Object) == "table" and Types[1][typeof(Object[1])]) or Types[1][typeof(Object)] then
		D.RC = D.RC or 0 -- RepeatCount
		D.R = D.R or false -- Repeat
		D.DT = D.DT or 0 -- DelayTime
		D.AP = D.AP or true -- AutoPlay
		D.CB = D.CB or false -- Callback
		if Types[1][typeof(Object)] then
			Tween = game:GetService("TweenService"):Create(Object, TweenInfo.new(D.T, D.ES, D.ED, D.RC, D.R, D.DT), Properties)
		elseif typeof(Object) == "table" then
			for Ind, Item in ipairs(Object) do
				Tween = game:GetService("TweenService"):Create(Item, TweenInfo.new(D.T, D.ES, D.ED, D.RC, D.R, D.DT), Properties)
			end
		end
		if D.AP then 
			Tween:Play() 
		end
		if D.CB then 
			Tween.Completed:Connect(D.CB) 
		end
		return Tween
	else
		D.SPS = (D.SPS and math.clamp(D.SPS, 1, 60)) or 60 -- Steps per second
		for Ind, Item in ipairs(Properties) do
			spawn(function() 
				for Ind2 = 1, D.T * D.SPS do 
					Easing.new(D.T, Assist, {Val = 1}, tostring(D.ED.Name..D.ES.Name)):Update(D.SPS) 
					wait(D.SPS) 
				end 
			end)
			if Types[2][typeof(Item[2])] then
				spawn(function() 
					for Ind2 = 1, D.T * D.SPS do 
						Object[Item[1]] = Object[Item[1]]:Lerp(Item[2], Assist.Val) 
						wait(D.T / D.SPS) 
					end 
				end)
			else
				spawn(function() 
					for Ind2 = 1, D.T * D.SPS do 
						Easing.new(D.T, Object, {[Item[1]] = Item[2]}, tostring(D.ED.Name..D.ES.Name)):Update(D.SPS) 
						wait(D.SPS) 
					end 
				end)
			end
		end
	end
end
