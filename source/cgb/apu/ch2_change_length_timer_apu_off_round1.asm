INCLUDE "all.inc"

; Check how NRx1 write behaves with different APU/DAC/Channel ON/OFF configurations.

EntryPoint:
    xor a
    ldh [rDIV], a

    DisableAPU
    EnableAPU

    Nops 4

    ; Initial length = 32
    ld a, $20
    ldh [rNR21], a

    ; Initial volume = F
    ld a, $F0
    ldh [rNR22], a

    ; Trigger = 1
    ; Length enable = 1
    ld a, $C0
    ldh [rNR24], a

    ; Wait a bit
    Wait 32768

    DisableAPU

    ; Initial length = 49
    ld a, $0F
    ldh [rNR21], a

    EnableAPU

    ; Initial volume = F
    ld a, $F0
    ldh [rNR22], a

    ; Trigger = 1
    ; Length enable = 1
    ld a, $C0
    ldh [rNR24], a

    Wait 260018

    ldh a, [rNR52]
    cp $f2

    jp nz, TestFail
    jp TestSuccess
