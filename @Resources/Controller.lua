function Initialize()
	config = {}

	config.band_count = RmGetUInt("BandCount", 100)
	config.bar_count = RmGetUInt("BarCount", 100)

	config.height = RmGetUInt("Height", 150)
	config.width = RmGetUNumber("Width", 1000)

	config.exp_scale_factor = RmGetUNumber("ExpScaleFactor", 0.8)
	config.stiffness = RmGetNumber("Stiffness", 1.02)
	if config.stiffness <= 1 then config.stiffness = 1 end
	config.spread = RmGetUNumber("Spread", 8)
	config.scale = RmGetUNumber("Scale", 7)

	config.fill_y = RmGetUNumber("FillY", 0)
	config.fill = RmGetUNumber("Fill", 0) > 0

	config.flip_vertical = (RmGetUNumber("FlipV", 0) > 0) and -1 or 1
	config.flip_horizontal = RmGetUNumber("FlipH", 0) > 0
	local horizontal_flipper = 0
	if config.flip_horizontal then
		horizontal_flipper = config.band_count+1
	end

	config.anchor_left = RmGetUNumber("AnchorLeft", 0) > 0
	config.anchor_right = RmGetUNumber("AnchorRight", 0) > 0

	config.force = RmGetUNumber("AnchorRight", 0) > 0

	band_measure = {}
	for i=1,config.band_count do
		band_measure[i] = SKIN:GetMeasure("MsBand" .. math.abs(horizontal_flipper - i))
	end
	bar_index_to_band = {}
	for i=1,config.bar_count do
		bar_index_to_band[i] = math.floor(map(i, 1, config.bar_count, 1, config.band_count))
	end

	buffer1_is_source = true
	buffer1 = {}
	buffer2 = {}
	for i=1,config.bar_count do
		buffer1[i] = 0
		buffer2[i] = 0
	end

	-- Create a load animation by setting the depth of the water in the center
	for i=config.bar_count/2-7,config.bar_count/2+7 do
		buffer1[i] = -config.scale
	end
end

function drawNiceCurveFromTable(t, t_min, t_max, curve_min_y, curve_max_y, curve_max_x, fill_line_y)
	local width_per_segment = curve_max_x / #t
	local current_y = clip(map(t[1], t_min, t_max, curve_min_y, curve_max_y), curve_min_y, curve_max_y)

	local output = {"", ""}
	if fill_line_y ~= nil then output[1] = ("%d,%d | LineTo "):format(-10, fill_line_y) end
	output[1] = output[1] .. ("%d,%d"):format(-10, 0)
	output[2] = ("LineTo %d,%d"):format(-10, current_y)
	for i=1,#t do
		local next_y = clip(map(t[i+1] or t[i], t_min, t_max, curve_min_y, curve_max_y), curve_min_y, curve_max_y)

		-- note: CurveTo end_x,end_y,control_x,control_y
		table.insert(output, ("CurveTo %d,%d,%d,%d"):format(
			width_per_segment * i,
			(current_y + next_y)/2,
			width_per_segment * i - width_per_segment/2,
			current_y
			))

		current_y = next_y
	end

	if fill_line_y ~= nil then table.insert(output, ("LineTo %d,%d"):format(curve_max_x, fill_line_y)) end

	return table.concat(output, "|")
end

function Update()
	local source, dest
	if buffer1_is_source then
		source = buffer1
		dest = buffer2
	else
		source = buffer2
		dest = buffer1
	end

	local max = config.scale
	for i=1,#dest do
		-- Increase the depth of this bar by the value of the parent band
		-- The lower frequencies are often very loud compared to the higher ones, so we exponentiate to a scale factor to even things out a bit
		dest[i] = dest[i] + config.flip_vertical*(band_measure[ bar_index_to_band[i] ]:GetValue()^config.exp_scale_factor)

		-- Create the "wavy" effect by adding the values of the adjacent bars and dividing by a "spring stiffness" value
		dest[i] = ( (source[i-1] or source[1]) + (source[i+1] or source[config.bar_count]) ) / config.stiffness - dest[i]
		-- Decay the spread of the waves by subtracting a fraction (higher values = more spread before dying) of the current height
		dest[i] = dest[i] - (dest[i] / config.spread)

		if math.abs(dest[i]) > max then max = math.abs(dest[i]) end
	end

	if config.anchor_left then dest[1] = 0 end
	if config.anchor_right then dest[#dest] = 0 end

	if max > config.scale then
		print(max)
	end

	SKIN:Bang("!SetOption", "Shape1", "MyPath", drawNiceCurveFromTable(dest, -config.scale, config.scale, 0, config.height, config.width, config.fill and config.fill_y or nil))

	buffer1_is_source = not buffer1_is_source
end

function clip(var, r1, r2)
	local limit = math.min(r1, r2)
	if var < limit then
		return limit
	end

	limit = math.max(r1, r2)
	if var > limit then
		return limit
	end

	return var
end
function map(nVar, nMin1, nMax1, nMin2, nMax2)
	return nMin2 + (nMax2 - nMin2) * ((nVar - nMin1) / (nMax1 - nMin1))
end

-- Returns a rainmeter variable rounded down to an integer
function RmGetInt(sVar, iDefault)
	return math.floor(SKIN:GetVariable(sVar, iDefault))
end
-- Returns a rainmeter variable rounded down to an integer, negative integers are converted to positive ones
function RmGetUInt(sVar, iDefault)
	return math.abs(RmGetInt(sVar, iDefault))
end
-- Returns a rainmeter variable represented as a (floating point) number
function RmGetNumber(sVar, iDefault)
	return tonumber(SKIN:GetVariable(sVar, iDefault))
end
-- Returns a rainmeter variable represented as a positive (floating point) number
function RmGetUNumber(sVar, iDefault)
	return math.abs(tonumber(SKIN:GetVariable(sVar, iDefault)))
end
-- Alias for SKIN:GetVariable
function RmGetStr(sVar, iDefault)
	return SKIN:GetVariable(sVar, iDefault)
end