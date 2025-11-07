INCLUDE "all.inc"

; Check write/read behavior of OCPS register.

EntryPoint:
    ld a, $10
    ldh [rOCPS], a

    ldh a, [rOCPS]
    cp $50

    jp nz, TestFailBeep
    jp TestSuccess