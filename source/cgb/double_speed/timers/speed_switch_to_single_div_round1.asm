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

    Wait 1

    ; Switch to double speed
    stop

    Wait 60

    ldh a, [rDIV]
    cp $00

    jp nz, TestFail
    jp TestSuccess