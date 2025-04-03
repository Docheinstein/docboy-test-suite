INCLUDE "all.inc"

; If Joypad is pressed before STOP, STOP is never exited because CPU it's halted.

EntryPoint:
    DisablePPU
    EnablePPU

    ; Go to line 20
    LongWait 20 * 114

    stop

    ; Never reached
    jp TestFail