function Initialize()
	oMsSec = SKIN:GetMeasure("MeasureSeconds")
	iOldVal = oMsSec:GetValue()
	iFPS = 0
end

function Update()
	if oMsSec:GetValue() ~= iOldVal then
		SKIN:Bang("!SetOption", "MeterFPS", "Text", iFPS .. " fps")
		iFPS = 0
		iOldVal = oMsSec:GetValue()
	end
	
	iFPS = iFPS + 1
end

function Disable()
	SKIN:Bang("!SetOption", "MeterFPS", "Text", "")
	SetDisabledState(1)
end
function Enable()
	SetDisabledState(0)
end
function SetDisabledState(state)
	SKIN:Bang("!SetOption", "LuaFps", "Disabled", state)
	SKIN:Bang("!WriteKeyValue", "LuaFps", "Disabled", state, "configurable.inc")
end
