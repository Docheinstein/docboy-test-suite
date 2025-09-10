INCLUDE "all.inc"

; Check how NRx1 write behaves with different APU/DAC/Channel ON/OFF configurations.

EntryPoint:
    xor a
    ldh [rDIV], a

    DisableAPU
    EnableAPU

    xor a
    ldh [rNR10], a

    ; Initial length = 32
    ld a, $20
    ldh [rNR11], a

    ; Initial volume = F
    ld a, $F0
    ldh [rNR12], a

    ; Trigger = 1
    ; Length enable = 1
    ld a, $C0
    ldh [rNR14], a

    ; Wait a bit
    Wait 32768

    DisableAPU

    ; Initial length = 49
    ld a, $0F
    ldh [rNR11], a

    EnableAPU

    ; Initial volume = F
    ld a, $F0
    ldh [rNR12], a

    ; Trigger = 1
    ; Length enable = 1
    ld a, $C0
    ldh [rNR14], a

    Wait 260019

    ldh a, [rNR52]
    cp $f0

    jp nz, TestFail
    jp TestSuccess
