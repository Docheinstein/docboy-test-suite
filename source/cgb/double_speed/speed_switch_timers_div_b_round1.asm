INCLUDE "all.inc"

; Check what happens to DIV during a speed switch.

EntryPoint:
    ; Reset DIV
    xor a
    ldh [rDIV], a

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; This delay does not affect the timing
    Nops 64

    ; Speed switch
    stop

    Nops 60

    ldh a, [rDIV]
    cp $00

    jp nz, TestFail
    jp TestSuccess
