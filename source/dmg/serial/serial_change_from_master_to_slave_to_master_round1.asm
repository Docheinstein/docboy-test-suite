INCLUDE "all.inc"

; Check the content of SB after the clock selector is changed from master to slave and back to master.

EntryPoint:
    ; Start serial transfer
    ld a, $81
    ldh [rSC], a

    Nops 512

    ; Change clock selector from master to slave
    ld a, $80
    ldh [rSC], a

    Nops 1024

    ldh a, [rSC]
    ld b, a

    ; Start serial transfer again
    ld a, $81
    ldh [rSC], a

    Nops 1010

    ldh a, [rSC]
    cp $ff

    jp nz, TestFail
    jp TestSuccess