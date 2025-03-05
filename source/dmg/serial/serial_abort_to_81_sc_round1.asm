INCLUDE "all.inc"

; Check the content of SC after a serial transfer is aborted.

EntryPoint:
    ; Start serial transfer
    ld a, $81
    ldh [rSC], a

    Nops 512

    ; Stop serial transfer
    ld a, $81
    ldh [rSC], a

    Nops 512

    ldh a, [rSC]
    cp $ff

    Nops 502

    ldh a, [rSC]
    cp $ff

    jp nz, TestFail
    jp TestSuccess