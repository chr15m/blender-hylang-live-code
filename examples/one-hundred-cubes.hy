(import bpy)
(import [helpers :as h])
(import [random [randint]])

; clear out any previous objects
(h.clear)

; build 100 cubes
(for [x (range 100)]
  (h.mk-ob h.cube {:loc [(randint -10 10) (randint -10 10) (randint -10 10)]}))
