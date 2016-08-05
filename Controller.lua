function Initialize()
	nBands = RmGetUInt("BandCount", 100)
	nBars = RmGetUInt("BarCount", 100)

	oMs = {}
	for i=1,nBands do
		oMs[i] = SKIN:GetMeasure("MsBand" .. i)
	end

	bUseMap1 = true
	tMap1 = {}
	tMap2 = {}
	for i=1,nBars do
		tMap1[i] = 0
		tMap2[i] = 0
	end

	for i=nBars/2-5,nBars/2+5 do
		tMap1[i] = -2
	end
end

function Update()
	local source, dest
	if bUseMap1 then
		source = tMap1
		dest = tMap2
	else
		source = tMap2
		dest = tMap1
	end

	for i=1,nBars do
		local n = mapi(i, 1, nBars, 1, nBands)
		dest[i] = dest[i] + oMs[n]:GetValue()

		dest[i] = (source[cl(i-1, 1, nBars)] + source[cl(i+1, 1, nBars)])/1.02 - dest[i]
		dest[i] = dest[i] - (dest[i] / 8)

		SKIN:Bang("!SetOption", "MsCalc" .. i, "Formula", map(-dest[i], -6, 6, -1, 1))
	end

	bUseMap1 = not bUseMap1
end

function cl(var, min, max)
	if var < min then 
		return min
	elseif var > max then
		return max
	end

	return var
end

function interpolate(weight, v1, v2)
	return weight * (v2 - v1) + v1
end

function map(nVar, nMin1, nMax1, nMin2, nMax2)
	return nMin2 + (nMax2 - nMin2) * ((nVar - nMin1) / (nMax1 - nMin1))
end

function mapi(nVar, nMin1, nMax1, nMin2, nMax2)
	return math.floor(nMin2 + (nMax2 - nMin2) * ((nVar - nMin1) / (nMax1 - nMin1)))
end

-- Returns a rainmeter variable rounded down to an integer
function RmGetInt(sVar, iDefault)
	return math.floor(SKIN:GetVariable(sVar, iDefault))
end
-- Returns a rainmeter variable rounded down to an integer, negative integers are converted to positive ones
function RmGetUInt(sVar, iDefault)
	return math.abs(RmGetInt(sVar, iDefault))
end