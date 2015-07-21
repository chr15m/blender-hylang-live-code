(import bpy)

; prefix all created objects with this so we can ignore everything else in the scene
(def prefix "HyLife")

; function to clear all of the objects created by this rig (good to call at the start of script)
(defn clear []
  ; get in object mode
  (try (apply bpy.ops.object.mode_set [] {"mode" "OBJECT"}) (catch [e Exception]))
  ; deselect everything first
  (apply bpy.ops.object.select_all [] {"action" "DESELECT"})
  ; loop through all objects
  (for [o bpy.context.scene.objects]
    ; if it has our prefix then delete it
    (if (o.name.startswith prefix)
      (setv o.select true)))
  ; go ahead and execute the delete on the selected objects
  (apply bpy.ops.object.delete [] {"use_global" false}))

; *** aliases ***

(defn f [] bpy.context.scene.frame_current)

; *** aliases - object builders ***

(def cube bpy.ops.mesh.primitive_cube_add)
(def torus bpy.ops.mesh.primitive_torus_add)

; *** aliases - transforms ***

(def scale bpy.ops.transform.resize)

; object parameter aliases

(def parameter-aliases {
  :loc 'location
  :l 'location})

(defn replace-aliases [k]
  ; convert :keyword params into regular python strings
  (name 
    ; if we have an alias for a particular key then use it
    (parameter-aliases.get k k)))

; *** do ***

(defn mk-ob [base-call params]
  (apply base-call [] (dict (list-comp [(replace-aliases k) (get params k)] [k params])))
  (let [[ob bpy.context.object]]
    ; mutate :(
    (setv ob.name prefix)
    (setv ob.show_name false)
    (setv ob.data.name (+ prefix "Mesh"))))

(defn tfrm [base-call arg]
  (apply base-call [] {"value" arg}))

(defn yo []
   (print "Yo!"))
