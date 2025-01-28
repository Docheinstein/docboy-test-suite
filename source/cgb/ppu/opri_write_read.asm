INCLUDE "all.inc"

; Check write/read behavior of OPRI register.

EntryPoint:
    ; Write 00 -> Read FE
    ld a, $00
    ldh [$FF6C], a
    ldh a, [$FF6C]

    cp $fe
    jp nz, TestFail

    ; Write FF -> Read FF
    ld a, $ff
    ldh [$FF6C], a
    ldh a, [$FF6C]

    cp $ff
    jp nz, TestFail

    jp TestSuccess