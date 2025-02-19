INCLUDE "all.inc"

; Start a serial transfer with slave clock and read SC.

EntryPoint:
    ; Start serial transfer
    ld a, $80
    ldh [rSC], a

    ldh a, [rSC]
    cp $fe

    jp nz, TestFail
    jp TestSuccess
