[Variables]
BarW=5
BarSp=1
BarColour=C2C2C2
Height=300
Separation=0
ExpScaleFactor=0.8
Stiffness=1.02
Spread=8
Scale=7

; Requires setting Rebuild to 1
BarCount=200
BandCount=128


[StBar]
W=#BarW#
X=#BarSp#R
SolidColor=#BarColour#

[MeasureAudio]
Measure=Plugin
Plugin=AudioLevel
Port=Output
FFTSize=16384
FFTOverlap=16000
FFTAttack=0
FFTDecay=0
FreqMin=20
FreqMax=10000
Sensitivity=30
Bands=(#BandCount#+1)

[Bounds]
Meter=Image
W=#CURRENTCONFIGWIDTH#
H=#CURRENTCONFIGHEIGHT#
DynamicVariables=1
SolidColor=255,0,0,30
Hidden=1
