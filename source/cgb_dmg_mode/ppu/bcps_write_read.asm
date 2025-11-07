INCLUDE "all.inc"

; Check write/read behavior of BCPS register.

EntryPoint:
    ld a, $10
    ldh [rBCPS], a

    ldh a, [rBCPS]
    cp $50

    jp nz, TestFail
    jp TestSuccess