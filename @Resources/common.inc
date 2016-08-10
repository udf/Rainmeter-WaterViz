[Rainmeter]
Update=15
DynamicWindowSize=1
ContextTitle=Rebuild skin
ContextAction=[!CommandMeasure "LuaRebuilder" "Rebuild()"]
ContextTitle2=Edit variables
ContextAction2=[notepad.exe "#CURRENTPATH#@Resources\variables.inc"]

[Variables]
BarW=5
BarSp=1
BarColour=FF0000
Height=300
Separation=0
ExpScaleFactor=0.8
Stiffness=1.02
Spread=8
Scale=7
HideBounds=0
BarCount=200
BandCount=128
FFTSize=16384
FFTOverlap=16000
FreqMin=20
FreqMax=10000
Sensitivity=30
HideFPS=0

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
Disabled=#HideFPS#

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
Hidden=#HideBounds#


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
