[Variables]
; The width (in pixels) of the skin
Width=1080

; The total height of the skin
Height=300

; Set to 1 to make the skin a filled shape (honestly it's hard to explain, just try it)
; FillY is the location of the horizontal line that defines the fill, recommended values are 0 or #Height#
Fill=0
FillY=#Height#

; If set to 1, the skin is flipped vertically ("bars" are inverted)
FlipV=0
; If set to 1, the skin is flipped horizontally (frequency increases leftwards)
FlipH=0

; If set to 1, the first "bar" is kept vertically centered
AnchorLeft=1
; If set to 1, the last "bar" is kept vertically centered
AnchorRight=1

; Options for the Shape meters
; See for https://docs.rainmeter.net/manual/meters/shape/#AttributeModifiers more info
; Options for the background of the skin
BackgroundOptions=StrokeWidth 0 | Fill Color 0,0,0,1
; Options for the forground of the skin
ForegroundOptions=StrokeWidth 3 | Stroke LinearGradient Rainbow
; Options for both the background and foreground of the skin (see WaterVizFill_* for an example)
SharedOptions=

; Controls the normalization of the bars. lower values means more normalization is applied
; Best kept at the default (0.7)
ExpScaleFactor=0.7

; Controls how "stiff" the liquid is, best kept at the default (1.02)
Stiffness=1.02

; Controls how far a disturbance travels before dying out
Spread=8

; The scale of the meter. Decrease if the curve seem to small; Increase if the curve is clipping
Scale=7

; Set this to 0 to show a fps counter
HideFPS=0

; The number of individual curve sections drawn
BarCount=256

; The number of bands that the AudioLevel plugin uses (best kept less than or equal to BarCount)
BandCount=256

; AudioLevel options
; see https://docs.rainmeter.net/manual/plugins/audiolevel/ for more info
; Decrease FFTSize to 8192, 4096, or 2048 if you have performace issues
FFTSize=8192
FFTOverlap=0
FreqMin=20
FreqMax=15000
Sensitivity=35

[Shape1]
Rainbow=180 | ED3237;0.0 | F58634;0.16 | FFF212;0.32 | 00A859;0.50 | 00AFEF;0.67 | 0083C8;0.83 | A8518A;1.0