INCLUDE "all.inc"

; Check how NRx1 write behaves with different APU/DAC/Channel ON/OFF configurations.

EntryPoint:
    xor a
    ldh [rDIV], a

    DisableAPU
    EnableAPU

    ; Initial length = 32
    ld a, $20
    ldh [rNR41], a

    ; Initial volume = F
    ld a, $F0
    ldh [rNR42], a

    ; Trigger = 1
    ; Length enable = 1
    ld a, $C0
    ldh [rNR44], a

    ; Wait a bit
    Wait 32768

    DisableAPU

    ; Initial length = 49
    ld a, $0F
    ldh [rNR41], a

    EnableAPU

    ; Initial volume = F
    ld a, $F0
    ldh [rNR42], a

    ; Trigger = 1
    ; Length enable = 1
    ld a, $C0
    ldh [rNR44], a

    Wait 260022

    ldh a, [rNR52]
    cp $f8

    jp nz, TestFail
    jp TestSuccess
