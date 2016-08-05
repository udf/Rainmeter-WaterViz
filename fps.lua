function Initialize()
	oMsSec = SKIN:GetMeasure("MeasureSeconds")
	iOldVal = oMsSec:GetValue()
	iFPS = 0
end

function Update()
	if oMsSec:GetValue() ~= iOldVal then
		SKIN:Bang('!SetOption', 'MeterFPS', 'Text', iFPS .. " fps")
		iFPS = 0
		iOldVal = oMsSec:GetValue()
	end
	
	iFPS = iFPS + 1
end