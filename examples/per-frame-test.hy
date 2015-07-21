(import bpy)
(import [helpers :as h])
(import math)

; clear the screen
(h.clear)

; make a cube at a position dependent on the frame modulus sine
(h.mk-ob h.cube {:loc [0 0 (* (math.sin (/ (h.f) 10.0)) 5)]})
