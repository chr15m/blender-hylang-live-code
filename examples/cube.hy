(import bpy)
(import [helpers :as h])

; clear the screen
(h.clear)
; create a cube at location 0 0 0
(h.mk-ob h.cube {:loc [0 0 0]})
