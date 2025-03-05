INCLUDE "all.inc"

; Check the content of SC after a serial transfer is aborted.

EntryPoint:
    ; Start serial transfer
    ld a, $81
    ldh [rSC], a

    Nops 512

    ; Stop serial transfer
    ld a, $00
    ldh [rSC], a

    ldh a, [rSC]
    cp $7e

    jp nz, TestFail
    jp TestSuccess