INCLUDE "all.inc"

; Check the content of SB after a serial transfer is aborted.

EntryPoint:
    ; Set SB
    ld a, %00110011
    ldh [rSB], a

    ; Start serial transfer
    ld a, $81
    ldh [rSC], a

    Nops 256

    ; Stop serial transfer
    ld a, $81
    ldh [rSC], a

    ; Wait a bit
    Nops 1024

    ldh a, [rSB]
    cp $ff

    jp nz, TestFail
    jp TestSuccess