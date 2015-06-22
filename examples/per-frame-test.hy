(import bpy)
(import helpers)

(helpers.clear)
(import math)

(apply bpy.ops.mesh.primitive_cube_add [] {"location" [0 0 (* (math.sin (/ bpy.context.scene.frame_current 10.0)) 5)]})
