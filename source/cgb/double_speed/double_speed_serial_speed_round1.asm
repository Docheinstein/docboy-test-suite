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

    LongWait 1015

    ldh a, [rSC]
    cp $fd

    jp nz, TestFail
    jp TestSuccess