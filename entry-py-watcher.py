import bpy
import os
import sys
import traceback
sys.path.append(os.path.abspath(os.path.dirname(__file__)))
sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), "modules")))
import hy
entry = os.path.abspath(os.path.join(os.path.dirname(__file__), os.environ.get("HY_ENTRY_FILE", "entry.hy")))

def run_hylang_file():
    print("Reloading " + entry)
    try:
        hy.importer.import_file_to_module("__main__", entry)
    except:
        traceback.print_exc()
    print(entry + " Done")

class ModalTimerOperator(bpy.types.Operator):
    """Operator which runs its self from a timer"""
    bl_idname = "wm.modal_timer_operator"
    bl_label = "Modal Timer Operator"
    last_check = 0
    
    _timer = None
    
    def modal(self, context, event):
        #if event.type in {'RIGHTMOUSE', 'ESC'}:
        #    return self.cancel(context)

        if event.type == 'TIMER':
            if os.path.exists(entry):
                statbuf = os.stat(entry)
                if statbuf.st_mtime > self.last_check:
                    self.last_check = statbuf.st_mtime
                    run_hylang_file()

        return {'PASS_THROUGH'}

    def execute(self, context):
        wm = context.window_manager
        self._timer = wm.event_timer_add(0.1, window=context.window)
        wm.modal_handler_add(self)
        print("Watching " + entry + " for changes and re-loading.")
        return {'RUNNING_MODAL'}

    def cancel(self, context):
        wm = context.window_manager
        wm.event_timer_remove(self._timer)
        print("Finished watching " + entry)
        return {'CANCELLED'}

def frame_change_handler(scene):
    run_hylang_file()

def register():
    bpy.utils.register_class(ModalTimerOperator)
    bpy.app.handlers.frame_change_post.append(frame_change_handler)

def unregister():
    bpy.utils.unregister_class(ModalTimerOperator)
    bpy.app.handlers.frame_change_post.remove(frame_change_handler)

if __name__ == "__main__":
    register()
    # test call
    bpy.ops.wm.modal_timer_operator()

