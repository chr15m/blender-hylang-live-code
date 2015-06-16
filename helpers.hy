(import bpy)

(defn clear []
  ; delete all meshes and start again
  (try (apply bpy.ops.object.mode_set [] {"mode" "OBJECT"}) (catch [e Exception]))
  (apply bpy.ops.object.select_by_type [] {"type" "MESH"})
  (apply bpy.ops.object.delete [] {"use_global" false})
    (for [m bpy.data.meshes]
      (bpy.data.meshes.remove m)))

(defn yo []
   (print "Yo!"))
