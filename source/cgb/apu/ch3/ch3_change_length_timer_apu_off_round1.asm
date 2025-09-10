INCLUDE "all.inc"

; Check how NRx1 write behaves with different APU/DAC/Channel ON/OFF configurations.

EntryPoint:
    xor a
    ldh [rDIV], a

    DisableAPU
    EnableAPU

    Nops 4

    ; DAC = 1
    ld a, $80
    ldh [rNR30], a

    ; Initial length = 32
    ld a, $20
    ldh [rNR31], a

    ; Trigger = 1
    ; Length enable = 1
    ld a, $C0
    ldh [rNR34], a

    ; Wait a bit
    Wait 32768

    DisableAPU

    ; Initial length = 49
    ld a, $0F
    ldh [rNR31], a

    EnableAPU

    ; DAC = 1
    ld a, $80
    ldh [rNR30], a

    ; Trigger = 1
    ; Length enable = 1
    ld a, $C0
    ldh [rNR34], a

    Wait 655350
    Wait 391100

    ldh a, [rNR52]
    cp $f4

    jp nz, TestFail
    jp TestSuccess
