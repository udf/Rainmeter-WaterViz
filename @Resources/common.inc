[Rainmeter]
Update=15
DynamicWindowSize=1
ContextTitle=Rebuild skin
ContextAction=[!CommandMeasure "LuaRebuilder" "Rebuild()"]

[LuaRebuilder]
Measure=Script
ScriptFile=#ROOTCONFIGPATH#@Resources\Rebuilder.lua
[LuaController]
Measure=Script
ScriptFile=#ROOTCONFIGPATH#@Resources\Controller.lua
[MeasureSeconds]
Measure=Time
Format="%S"
[LuaFps]
Measure=Script
ScriptFile="#ROOTCONFIGPATH#@Resources\fps.lua"
Disabled=0

[MeterFPS]
Meter=String
Text=""
StringAlign=LEFT
StringStyle=BOLD
StringEffect=SHADOW
FontEffectColor=0,0,0,200
FontColor=FFFFFF
FontSize=10
AntiAlias=1
