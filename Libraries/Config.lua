--[[
	T : Time
	ES : EasingStyle
	ED : EasingDirection
	RC : RepeatCount
	R : Repeat
	DT : DelayTime
	AP : AutoPlay
	CB : Callback
	BC : BezierCurves
	SPS : StepsPerSecond
	D : Delay
--]]

return {
	TweenService = game:GetService'TweenService',
	Easing = require(script.Easing),
	
	Defaults = {
		T = 0.25,
		ES = Enum.EasingStyle.Quart,
		ED = Enum.EasingDirection.Out,
		RC = 0,
		R = false,
		DT = 0,
		AP = true,
		CB = false,
		BC = nil,
		SPS = 60,
		D = nil
	}
	
}
