INCLUDE "all.inc"

; Start a serial transfer with master clock and read SC.

EntryPoint:
    ; Start serial transfer
    ld a, $81
    ldh [rSC], a

    ldh a, [rSC]
    cp $ff

    jp nz, TestFail
    jp TestSuccess

