function Initialize()
	measure_seconds = SKIN:GetMeasure("MeasureSeconds")
	previous_value = measure_seconds:GetValue()
	current_framecount = 0
end

function Update()
	if measure_seconds:GetValue() ~= previous_value then
		SKIN:Bang("!SetOption", "MeterFPS", "Text", current_framecount .. " fps")
		current_framecount = 0
		previous_value = measure_seconds:GetValue()
	end
	
	current_framecount = current_framecount + 1
end