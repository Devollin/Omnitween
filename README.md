# Omnitween
![alt text](https://github.com/Devollin/OmniTween/blob/master/assets/Omnitween-logo-v1.png?raw=true)
**_Notice: this module is FAR from finished, but basic tweening and "Tweening values on tables" are currently complete._**
**_Omnitween_** is an **open source** module to tween nearly anything in **Roblox** in an easy to use function, while also being capable of handling:
- Bezier Curves (Soon)
- Sequential animations (Soon)
- Tweening DataTypes that are not supported with TweenService (Soon)
  - NumberSequence
  - ColorSequence
- Tweening DataTypes that are not natively able to be tweened or lerped (Soon)
  - Vector3int16
  - Vector2int16
  - UDim
  - Region3
  - Region3int16
  - Rect
  - NumberRange
- Model tweening (Soon)
- Tweening values on tables (Weak implementation for now, will improve on later.)

## Usage

Using this module is easy!
```lua
local Omnitween = require(game:GetService("ReplicatedStorage").Omnitween) -- Or wherever you want to put it!

local somePart = workspace.Part
local someOtherPart = workspace.OtherPart
local aBlankReference
Omnitween(somePart, {Position = Vector3.new(5, 25, 125), Transparency = 0.5}, {Time = 5, CB = function(object, properties, modifiers, playbackState)
  print(playbackState)
  aBlankReference = Omnitween({someOtherPart, somePart}, {Color = Color3.new(1, 0.5, 0)}, {T = 10})
  wait(5)
  aBlankReference:Cancel()
end})
```
Omnitween isn't a high priority of mine, but I will be trying to finish it. 
As of writing this (1.10.2021) I plan to drop TweenService in favor of a more performant solution that would benefit both traditional tweening on instances and that done on arrays or dictionaries, whatever it may be.
