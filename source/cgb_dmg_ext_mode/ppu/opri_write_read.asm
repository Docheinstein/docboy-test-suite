INCLUDE "all.inc"

; Check write/read behavior of OPRI register.

EntryPoint:
    ld a, $00
    ldh [rOPRI], a

    ldh a, [rOPRI]
    cp $fe
    jp nz, TestFailBeep

    ld a, $01
    ldh [rOPRI], a

    ldh a, [rOPRI]
    cp $ff
    jp nz, TestFailBeep

    jp TestSuccess
