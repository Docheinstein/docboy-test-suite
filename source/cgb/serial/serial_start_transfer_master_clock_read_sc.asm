INCLUDE "all.inc"

EntryPoint:
    ; Start serial transfer
    ld a, $81
    ldh [rSC], a

    ldh a, [rSC]
    cp $fc

    jp nz, TestFail
    jp TestSuccess

