INCLUDE "all.inc"

; Check the timing of serial transfer in double speed mode.

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
    ld a, $81
    ldh [rSC], a

    Wait 1016

    ldh a, [rSC]
    cp $7d

    jp nz, TestFail
    jp TestSuccess
