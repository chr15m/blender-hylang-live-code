(import bpy)
(import [helpers [clear mk-ob tfrm f cube torus scale]])

(clear)
(import math)

(mk-ob cube [0 0 (* (math.sin (/ (f) 10.0)) 2)])
(tfrm scale [0.5 0.5 0.5])

(mk-ob cube [0 0 (* (math.sin (+ (/ (f) 10.0) 3)) 2)])
(tfrm scale [0.5 0.5 0.5])

(mk-ob torus [0 0 0])
(tfrm scale [2 2 2])
