(import bpy)
(import [helpers :as h])
(import [random [randint]])

(h.clear)

(for [x (range 100)]
  (h.mk-ob h.cube [(randint -10 10) (randint -10 10) (randint -10 10)]))
