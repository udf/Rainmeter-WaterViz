[Variables]
; The width (in pixels) of each bar
BarW=5

; The space (in pixels) between each bar
BarSp=1

; The color of the bars
BarColour=C2C2C2

; The total height of the skin
Height=300

; The separation between the upper and lower parts of the bars
; Useful if you are placing the skin on a line
Separation=0

; Controls the normalization of the bars. higher values means more normalization is applied
; Best kept at the default (0.8)
ExpScaleFactor=0.8

; Controls how "stiff" the liquid is, best kept at the default (1.02)
Stiffness=1.02

; Controls how far a disturbance travels before dying out
Spread=8

; The scale of the meter. Decrease if the bars seem to small; Increase if the bars are clipping
Scale=7

; Set this to 1 to show a black background
; Useful when positioning the skin (or checking for clipping)
ShowBounds=1

; The number of bars drawn
BarCount=200

; The number of bands that the AudioLevel plugin uses
BandCount=128

; AudioLevel options
; see https://docs.rainmeter.net/manual/plugins/audiolevel/ for more info
FFTSize=16384
FFTOverlap=16000
FreqMin=20
FreqMax=10000
Sensitivity=30
