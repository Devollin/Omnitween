local Config = require(script.Parent.Config)

return function(Object, Properties, Data)
	return Config.TweenService:Create(Object, TweenInfo.new(Data.T, Data.ES, Data.ED, Data.RC, Data.R, Data.DT), Properties)
end
