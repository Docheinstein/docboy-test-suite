INCLUDE "all.inc"

; Check write/read behavior of BCPD register.

EntryPoint:
    ld a, $10
    ldh [rBCPD], a

    ldh a, [rBCPD]
    cp $ff

    jp nz, TestFail
    jp TestSuccess