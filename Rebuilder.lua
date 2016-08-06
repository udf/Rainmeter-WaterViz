function Initialize()
	-- Class definitions
	-- iniBuilder: Assists with creating a structured ini
	iniBuilder = class(function(o)
		o.tData = {}
	end)
	function iniBuilder:NewSection(sSectionName)
		-- iniSectionBuilder: Sub class of iniBuilder, Assists with creating a structured ini section
		iniSectionBuilder = class(function(o, sSectionName, oParent)
			o.oParent = oParent
			o.tData = {}
			table.insert(o.tData, ("\[%s\]"):format(sSectionName))
		end)
		function iniSectionBuilder:AddKey(sKey, sVal)
			table.insert(self.tData, ("%s=%s"):format(sKey, sVal))
		end
		function iniSectionBuilder:Commit()
			local iParentSize = #self.oParent.tData
			for i=1,#self.tData do
				table.insert(self.oParent.tData, self.tData[i])
			end
		end

		return iniSectionBuilder(sSectionName, self)
	end
	function iniBuilder:ToString()
		return table.concat(self.tData, "\n")
	end

	-- Rebuild the skin if the ini says that we should
	if RmGetInt("Rebuild", 0) == 1 then
		Rebuild()
	end
end

-- TODO: Figure out if i actually need to leave this here
function Update()
end

function Rebuild()
	-- If rebuild was selected from the context menu then we should refresh the skin (to reload the variables) and then rebuild the meters
	if RmGetInt("Rebuild", 0) ~= 1 then
		-- Write a key to the ini so that we know next time that we should call this function to rebuild the meters
		SKIN:Bang("!WriteKeyValue", "Variables", "Rebuild", "1")
		SKIN:Bang("!Refresh")
		return
	end
	-- Revert the key to 0 to prevent an infinite loop (which is not as fun as it seems)
	SKIN:Bang("!WriteKeyValue", "Variables", "Rebuild", "0")

	print("REBUILD TIME")

	local iBandCount = RmGetUInt("BandCount", 100)
	local iBarCount = RmGetUInt("BarCount", 100)

	oIni = iniBuilder()

	local o = oIni:NewSection("MeasureAudio")
		o:AddKey("Measure", "Plugin")
		o:AddKey("Plugin", "AudioLevel")
		o:AddKey("Port", "Output")
		o:AddKey("FFTSize", 16384)
		o:AddKey("FFTOverlap", 16000)
		o:AddKey("FFTAttack", 0)
		o:AddKey("FFTDecay", 0)
		o:AddKey("FreqMin", 25)
		o:AddKey("FreqMax", 10000)
		o:AddKey("Sensitivity", 30)
		o:AddKey("Bands", iBandCount + 1)
	o:Commit()
	
	for i=1,iBandCount do
		local o = oIni:NewSection("MsBand" .. i)
			o:AddKey("Measure", "Plugin")
			o:AddKey("Plugin", "AudioLevel")
			o:AddKey("Parent", "MeasureAudio")
			o:AddKey("Type", "Band")
			o:AddKey("BandIdx", i)
		o:Commit()
	end

	for i=1,iBarCount do
		local o = oIni:NewSection("MsCalc" .. i)
			o:AddKey("Measure", "Calc")
			o:AddKey("Formula", 0)
		o:Commit()
		local o = oIni:NewSection("MsCalcL" .. i)
			o:AddKey("Measure", "Calc")
			o:AddKey("Formula", "-MsCalc" .. i)
		o:Commit()
		local o = oIni:NewSection("MtBar" .. i)
			o:AddKey("Meter", "Bar")
			o:AddKey("MeterStyle", "StBar")
			o:AddKey("MeasureName", "MsCalc" .. i)
		o:Commit()
		local o = oIni:NewSection("MtBarL" .. i)
			o:AddKey("Meter", "Bar")
			o:AddKey("MeterStyle", "StBar|StBarL")
			o:AddKey("MeasureName", "MsCalcL" .. i)
		o:Commit()
	end

	local file = io.open(RmGetString("CURRENTPATH") .. "generated.inc", "w+")
	file:write(oIni:ToString())
	file:close()

	SKIN:Bang("!Refresh")
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
	return number(SKIN:GetVariable(sVar, iDefault))
end
-- Returns a rainmeter variable respresented as a string (alias of SKIN:GetVariable)
function RmGetString(sVar, sDefault)
	return SKIN:GetVariable(sVar, sDefault)
end

-- class.lua
-- Compatible with Lua 5.1 (not 5.0).
function class(base, init)
	local c = {}	 -- a new class instance
	if not init and type(base) == "function" then
		init = base
		base = nil
	elseif type(base) == "table" then
	 -- our new class is a shallow copy of the base class!
		for i,v in pairs(base) do
			c[i] = v
		end
		c._base = base
	end
	-- the class will be the metatable for all its objects,
	-- and they will look up their methods in it.
	c.__index = c

	-- expose a constructor which can be called by <classname>(<args>)
	local mt = {}
	mt.__call = function(class_tbl, ...)
	local obj = {}
	setmetatable(obj,c)
	if init then
		init(obj,...)
	else 
		-- make sure that any stuff from the base class is initialized!
		if base and base.init then
		base.init(obj, ...)
		end
	end
	return obj
	end
	c.init = init
	c.is_a = function(self, klass)
		local m = getmetatable(self)
		while m do 
			if m == klass then return true end
			m = m._base
		end
		return false
	end
	setmetatable(c, mt)
	return c
end