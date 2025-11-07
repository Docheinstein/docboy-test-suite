INCLUDE "all.inc"

; Check write/read behavior of OPRI register.

EntryPoint:
    ; Write 00 -> Read FE
    ld a, $00
    ldh [rOPRI], a
    ldh a, [rOPRI]

    cp $fe
    jp nz, TestFail

    ; Write FF -> Read FF
    ld a, $ff
    ldh [rOPRI], a
    ldh a, [rOPRI]

    cp $ff
    jp nz, TestFail

    jp TestSuccess