INCLUDE "all.inc"

; Check what happens to DIV during a speed switch from single to double speed.

EntryPoint:
    ; Reset DIV
    xor a
    ldh [rDIV], a

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Switch to double speed
    stop

    Nops 60

    ldh a, [rDIV]
    cp $00

    jp nz, TestFail
    jp TestSuccess
