(import bpy)
(import math)
(import [helpers [clear mk-ob tfrm f cube torus scale]])

(clear)

(mk-ob cube {:l [0 0 (* (math.sin (/ (f) 10.0)) 2)]})
(tfrm scale [0.5 0.5 0.5])

(mk-ob cube {:l [0 0 (* (math.sin (+ (/ (f) 10.0) 3)) 2)]})
(tfrm scale [0.5 0.5 0.5])

(mk-ob torus {:l [0 0 0]})
(tfrm scale [2 2 2])
