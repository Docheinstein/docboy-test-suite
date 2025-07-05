INCLUDE "all.inc"

; If Joypad Interrupt is enabled and Joypad is pressed before STOP, STOP is not exited because it's halted.

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
    jp TestFail