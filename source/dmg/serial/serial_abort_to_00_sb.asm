INCLUDE "all.inc"

; Check the content of SB after a serial transfer is aborted.

EntryPoint:
    ; Set SB
    ld a, %00110011
    ldh [rSB], a

    ; Start serial transfer
    ld a, $81
    ldh [rSC], a

    Wait 256

    ; Stop serial transfer
    ld a, $00
    ldh [rSC], a

    ; Wait a bit
    Wait 1024

    ldh a, [rSB]
    cp $cf

    jp nz, TestFail
    jp TestSuccess