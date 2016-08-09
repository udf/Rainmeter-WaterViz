[Rainmeter]
Update=15
DynamicWindowSize=1
ContextTitle=Rebuild skin
ContextAction=[!CommandMeasure "LuaRebuilder" "Rebuild()"]

[StBar]
W=#BarW#
X=#BarSp#R
SolidColor=#BarColour#


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

[MeasureAudio]
Measure=Plugin
Plugin=AudioLevel
Port=Output
FFTAttack=0
FFTDecay=0
FFTSize=#FFTSize#
FFTOverlap=#FFTOverlap#
FreqMin=#FreqMin#
FreqMax=#FreqMax#
Sensitivity=#Sensitivity#
Bands=(#BandCount#+1)

[Bounds]
Meter=Image
W=#CURRENTCONFIGWIDTH#
H=#CURRENTCONFIGHEIGHT#
DynamicVariables=1
SolidColor=0,0,0,100
Hidden=#ShowBounds#


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
