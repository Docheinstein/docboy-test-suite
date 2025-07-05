INCLUDE "all.inc"

; Writing to STAT enables all the STAT interrupts (as if FF would have been written to STAT).
; Check the timing for STAT's HBlank interrupt with different SCXs.

EntryPoint:
    DisablePPU

    ; Write SCX=2
    ld a, $02
    ldh [rSCX], a

    EnablePPU

    Wait 114

    xor a
    ldh [rIF], a

    Nops 55

    ldh [rSTAT], a

    ldh a, [rIF]
    cp $e0

    jp nz, TestFail

    jp TestSuccess
