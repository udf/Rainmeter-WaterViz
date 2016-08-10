function Initialize()
	nBands = RmGetUInt("BandCount", 100)
	nBars = RmGetUInt("BarCount", 100)

	oMs = {}
	for i=1,nBands do
		oMs[i] = SKIN:GetMeasure("MsBand" .. i)
	end
	oMt = {}
	for i=1,nBars do
		oMt[i] = SKIN:GetMeter("MtBar" .. i)
	end

	bUseMap1 = true
	tHeightMap1 = {}
	tHeightMap2 = {}
	tParentBand = {}
	for i=1,nBars do
		tHeightMap1[i] = 0
		tHeightMap2[i] = 0

		tParentBand[i] = mapi(i, 1, nBars, 1, nBands)
	end

	-- Create a load animation by setting the depth of the water in the center
	for i=nBars/2-7,nBars/2+7 do
		tHeightMap1[i] = -3
	end

	tC = {}
	tC.Separation = RmGetUInt("Separation", 0)
	tC.Height = RmGetUInt("Height", 150)/2
	tC.ExpScaleFactor = RmGetUNumber("ExpScaleFactor", 0.8)
	tC.Stiffness = RmGetNumber("Stiffness", 1.02)
	if tC.Stiffness <= 1 then tC.Stiffness = 1 end
	tC.Spread = RmGetUNumber("Spread", 8)
	tC.Scale = RmGetUNumber("Scale", 7)
end

function Update()
	local source, dest
	if bUseMap1 then
		source = tHeightMap1
		dest = tHeightMap2
	else
		source = tHeightMap2
		dest = tHeightMap1
	end

	for i=1,nBars do
		-- Increase the depth of this bar by the value of the parent band
		-- The lower frequencies are often very loud compared to the higher ones, so we exponentiate to a scale factor to even things out a bit
		dest[i] = dest[i] + oMs[ tParentBand[i] ]:GetValue()^tC.ExpScaleFactor

		-- Create the "wavy" effect by adding the values of the adjacent bars and dividing by a "spring stiffness" value
		dest[i] = (source[cl(i-1, 1, nBars)] + source[cl(i+1, 1, nBars)])/tC.Stiffness - dest[i]
		-- Decay the spread of the waves by subtracting a fraction (higher values = more spread before dying) of the current height
		dest[i] = dest[i] - (dest[i] / tC.Spread)

		-- check for clipping
		if -dest[i] > tC.Scale then
			print( ("Clipping detected (%.2f, %d); consider increasing Scale in %s\\@Resources\\variables.inc"):format(-dest[i], i, RmGetStr("CURRENTCONFIG")) )
		end

		oMt[i]:SetH( ImgBarH(-dest[i]/tC.Scale, tC.Height) )
		oMt[i]:SetY( ImgBarY(-dest[i]/tC.Scale, tC.Height, tC.Separation) )
	end

	bUseMap1 = not bUseMap1
end


function ImgBarH(n, r)
	return math.abs(n)*r
end
function ImgBarY(n, r, s)
	if n > 0 then
		return (1-n)*r
	end
	return r + s - 1
end
function cl(var, min, max)
	if var < min then 
		return min
	elseif var > max then
		return max
	end

	return var
end
function map(nVar, nMin1, nMax1, nMin2, nMax2)
	return nMin2 + (nMax2 - nMin2) * ((nVar - nMin1) / (nMax1 - nMin1))
end
function mapi(nVar, nMin1, nMax1, nMin2, nMax2)
	return math.floor(map(nVar, nMin1, nMax1, nMin2, nMax2))
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