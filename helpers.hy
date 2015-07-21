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
(def resize bpy.ops.transform.resize)
(def rotate bpy.ops.transform.rotate)
(def translate bpy.ops.transform.translate)

; object parameter aliases

(def parameter-aliases {
  :loc 'location
  :l 'location
  :s 'scale
  :r 'rotate
  :rot 'rotate
  :t 'translate
  :trans 'translate})

(defn replace-alias [k]
  ; convert :keyword params into regular python strings
  (name 
    ; if we have an alias for a particular key then use it
    (parameter-aliases.get k k)))

; run through parameters replacing all with aliases
(defn replace-aliases [params]
  (dict (list-comp [(replace-alias k) (get params k)] [k params])))

; filter the parameters list into ones that can go into blender calls versus ones we apply manually
(defn filter-internal-param [param]
  (in param ["scale" "rotate"]))

; *** do ***

(defn mk-ob [base-call &optional [params {}]]
  (let [[params-unaliased (replace-aliases params)]
        [params-for-call (dict-comp p (params-unaliased.get p) [p params-unaliased] (not (filter-internal-param p)))]
        [params-for-us (dict-comp p (params-unaliased.get p) [p params-unaliased] (filter-internal-param p))]]
    (apply base-call [] params-for-call)
    (let [[ob bpy.context.object]]
      ; mutate :(
      ; set the name to our prefix so we can recognise out own objects later
      (setv ob.name prefix)
      (setv ob.show_name false)
      (setv ob.data.name (+ prefix "Mesh"))
      ; scale the object if requested
      (if (in "scale" params-for-us)
        (apply scale [] {"value" (params-for-us.get "scale")}))
      (if (in "rotate" params-for-us)
        (apply rotate [] {"value" (first (params-for-us.get "rotate")) "axis" (slice (params-for-us.get "rotate") 1)}))
      (if (in "translate" params-for-us)
        (apply translate [] {"value" (params-for-us.get "translate")}))
      ob)))

(defn tfrm [base-call arg &optional args]
  (let [[v {"value" arg}]]
    (apply base-call [] (if args (merge-with identity v (replace-aliases args)) v))))

(def tf tfrm)

(defn yo []
   (print "Yo!"))
