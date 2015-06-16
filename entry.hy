(import bpy)
(import helpers)

(helpers.clear)
(import [random [randint]])

(for [x (range 100)]
  (apply bpy.ops.mesh.primitive_cube_add [] {"location" [(randint -10 10) (randint -10 10) (randint -10 10)]}))
