[Variables]
; The width (in pixels) of the skin
Width=1000

; The total height of the skin
Height=300

; The color of the curve
CurveColor=000000

; The width of the line used to draw the curve
StrokeWidth=1.5

; Controls the normalization of the bars. lower values means more normalization is applied
; Best kept at the default (0.8)
ExpScaleFactor=0.8

; Controls how "stiff" the liquid is, best kept at the default (1.03)
Stiffness=1.03

; Controls how far a disturbance travels before dying out
Spread=8

; The scale of the meter. Decrease if the curve seem to small; Increase if the curve is clipping
Scale=7

; Set this to 0 to show a fps counter
HideFPS=1

; The number of individual curve sections drawn
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