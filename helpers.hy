(import bpy)

(defn clear []
  ; delete all meshes and start again
  (try (apply bpy.ops.object.mode_set [] {"mode" "OBJECT"}) (catch [e Exception]))
  (apply bpy.ops.object.select_by_type [] {"type" "MESH"})
  (apply bpy.ops.object.delete [] {"use_global" false})
    (for [m bpy.data.meshes]
      (bpy.data.meshes.remove m)))

; prefix all created objects with this so we can ignore everything else in the scene
(def prefix "HyLife")

; *** aliases ***

(defn f [] bpy.context.scene.frame_current)

; *** aliases - object builders ***

(def cube bpy.ops.mesh.primitive_cube_add)
(def torus bpy.ops.mesh.primitive_torus_add)

; *** aliases - transforms ***

(def scale bpy.ops.transform.resize)

; *** do ***

(defn mk-ob [base-call location]
  (apply base-call [] {"location" location})
  (let [[ob bpy.context.object]]
    ; mutate :(
    (setv ob.name prefix)
    (setv ob.show_name true)
    (setv ob.data.name (+ prefix "Mesh"))))

(defn tfrm [base-call arg]
  (apply base-call [] {"value" arg}))

(defn yo []
   (print "Yo!"))
