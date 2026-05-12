INCLUDE "all.inc"

; If Joypad is pressed before STOP, but Joypad interrupt is enabled:
; - CPU enters HALT state instead of STOP state.
; - HALT is exited when button is pressed because Joypad interrupt is enabled
;   (even on button release, because of switch bouncing)

EntryPoint:
    DisablePPU

    ; Enable JOYPAD interrupt
    ld a, IEF_HILO
    ldh [rIE], a

    xor a
    ldh [rIF], a

    EnablePPU

    ; Go to line 20
    Wait 20 * 114

    stop

    ; Never reached
    jp TestSuccess