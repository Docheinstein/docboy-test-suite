INCLUDE "all.inc"

; Check write/read behavior of OPRI register.

EntryPoint:
    ld a, $00
    ldh [rOPRI], a

    ldh a, [rOPRI]
    cp $ff

    jp nz, TestFail
    jp TestSuccess
