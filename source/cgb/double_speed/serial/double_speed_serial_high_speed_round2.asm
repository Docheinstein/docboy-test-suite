INCLUDE "all.inc"

; Check the timing of serial transfer in double speed mode with high speed serial enabled.

EntryPoint:
    ; Reset DIV
    xor a
    ldh [rDIV], a

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Change speed
    stop

    ; Start serial transfer
    ld a, $83
    ldh [rSC], a

    Nops 28

    ldh a, [rSC]
    cp $7f

    jp nz, TestFail
    jp TestSuccess
