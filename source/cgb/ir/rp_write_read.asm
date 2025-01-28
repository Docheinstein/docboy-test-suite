INCLUDE "all.inc"

; Check write/read behavior of RP register.

EntryPoint:
    ; Write 00 -> Read 3E
    ld a, $00
    ldh [rRP], a
    ldh a, [rRP]

    cp $3e
    jp nz, TestFail

    ; Write FF -> Read FF
    ld a, $ff
    ldh [rRP], a
    ldh a, [rRP]

    cp $ff
    jp nz, TestFail

    jp TestSuccess