return {
	CFrame = function(A, B, C, D, E, F, G, H, I) 
		return CFrame.new(A, B, C, D or nil, E or nil, F or nil, G or nil, H or nil, I or nil) 
	end,
	
	Color3 = function(A, B, C) 
		return Color3.new(A, B, C) 
	end,
	
	NumberRange = function(A, B) 
		return NumberRange.new(A, B or nil) 
	end,
	
	Rect = function(A, B, C, D) 
		return Rect.new(A, B, C or nil, D or nil) 
	end,
	
	Region3 = function(A, B, C) 
		return Region3.new(A, B, C) 
	end,
	
	Region3int16 = function(A, B, C) 
		return Region3int16.new(A, B, C) 
	end,
	
	UDim = function(A, B) 
		return UDim.new(A, B) 
	end,
	
	UDim2 = function(A, B, C, D) 
		return UDim2.new(A, B, C or nil, D or nil) 
	end,
	
	Vector2int16 = function(A, B) 
		return Vector2int16.new(A, B) 
	end,
	
	Vector3 = function(A, B, C) 
		return Vector3.new(A, B, C) 
	end,
	
	Vector3int16 = function(A, B, C) 
		return Vector3int16.new(A, B, C) 
	end,
	
	ColorSequence = function(A, B) 
		return ColorSequence.new(A, B or nil) 
	end,
	
	NumberSequence = function(A, B) 
		return NumberSequence.new(A, B or nil) 
	end
}
