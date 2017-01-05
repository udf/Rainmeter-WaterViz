[Variables]
; The width (in pixels) of the skin
Width=1000

; The total height of the skin
Height=300

; Options for the Shape meter
; See for https://docs.rainmeter.net/manual/meters/shape/#AttributeModifiers more info
CurveOptions=StrokeWidth 3 | Stroke LinearGradient Rainbow
;CurveOptions=StrokeWidth 3 | Stroke Color FFFFFF

; Controls the normalization of the bars. lower values means more normalization is applied
; Best kept at the default (0.8)
ExpScaleFactor=0.8

; Controls how "stiff" the liquid is, best kept at the default (1.02)
Stiffness=1.02

; Controls how far a disturbance travels before dying out
Spread=8

; The scale of the meter. Decrease if the curve seem to small; Increase if the curve is clipping
Scale=7

; Set this to 0 to show a fps counter
HideFPS=1

; The number of individual curve sections drawn
BarCount=256

; The number of bands that the AudioLevel plugin uses (best kept less than or equal to BarCount)
BandCount=256

; AudioLevel options
; see https://docs.rainmeter.net/manual/plugins/audiolevel/ for more info
FFTSize=16384
FFTOverlap=16000
FreqMin=20
FreqMax=15000
Sensitivity=35

[Shape1]
Rainbow=180 | ED3237;0.0 | F58634;0.16 | FFF212;0.32 | 00A859;0.50 | 00AFEF;0.67 | 0083C8;0.83 | A8518A;1.0