INCLUDE "all.inc"

; If Joypad Interrupt is enabled and Joypad is pressed before STOP, STOP is not exited because it's halted.
; But if Joypad is released and pressed again, STOP is exited.

EntryPoint:
    DisablePPU

    ; Enable JOYPAD interrupt
    ld a, IEF_HILO
    ldh [rIE], a

    xor a
    ldh [rIF], a

    EnablePPU

    ; Go to line 20
    LongWait 20 * 114

    stop

    jp TestSuccess