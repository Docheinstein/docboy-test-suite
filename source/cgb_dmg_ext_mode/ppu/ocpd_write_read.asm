INCLUDE "all.inc"

; Check write/read behavior of OCPD register.

EntryPoint:
    ld a, $10
    ldh [rOCPD], a

    ldh a, [rOCPD]
    cp $ff

    jp nz, TestFailBeep
    jp TestSuccess