INCLUDE "all.inc"

; If Joypad is pressed before STOP:
; - CPU enters HALT state instead of STOP state.
; - HALT is never exited because Joypad interrupt is disabled

EntryPoint:
    DisablePPU
    EnablePPU

    ; Go to line 20
    Wait 20 * 114

    stop

    ; Never reached
    jp TestFail