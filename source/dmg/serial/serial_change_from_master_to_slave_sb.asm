INCLUDE "all.inc"

; Check the content of SC after the clock selector is changed from master to slave.

EntryPoint:
    ; Start serial transfer
    ld a, $81
    ldh [rSC], a

    Nops 512

    ; Change clock selector from master to slave
    ld a, $80
    ldh [rSC], a

    ldh a, [rSB]
    cp $1f

    jp nz, TestFail
    jp TestSuccess