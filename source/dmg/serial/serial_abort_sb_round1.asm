INCLUDE "all.inc"

; Check the content of SB after a serial transfer is aborted.

EntryPoint:
    ld a, %10100010
    ldh [rSB], a

    ; Start serial transfer
    ld a, $81
    ldh [rSC], a

    Nops 57

    ; Stop serial transfer
    ld a, $01
    ldh [rSC], a

    ldh a, [rSB]
    cp $a2

    jp nz, TestFail
    jp TestSuccess
