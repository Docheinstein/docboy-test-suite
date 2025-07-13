INCLUDE "all.inc"

; Check the timing of DIV during speed switch to single speed.

EntryPoint:
    DisablePPU

    ; Reset DIV
    xor a
    ldh [rDIV], a

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    stop

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    Nops 1

    ; Switch to double speed
    stop

    Nops 61

    ldh a, [rDIV]
    cp $01

    jp nz, TestFail
    jp TestSuccess