INCLUDE "all.inc"

; Writing to STAT enables all the STAT interrupts (as if FF would have been written to STAT).
; Check the timing for STAT's HBlank interrupt with different SCXs.

EntryPoint:
    DisablePPU

    ; Write SCX=5
    ld a, $05
    ldh [rSCX], a

    EnablePPU

    LongWait 114

    xor a
    ldh [rIF], a

    Nops 56

    ldh [rSTAT], a

    ldh a, [rIF]
    cp $e0

    jp nz, TestFail

    jp TestSuccess
