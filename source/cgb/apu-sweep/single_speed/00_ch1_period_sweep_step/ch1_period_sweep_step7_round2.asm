INCLUDE "all.inc"

; Check when CH1 is disabled due to period sweep timing overflow with step 7.

EntryPoint:
    xor a
    ldh [rDIV], a

    DisableAPU
    EnableAPU

    ; Pace = 3
    ; Direction = 0 (increase)
    ; Step = 7
    ld a, $37
    ldh [rNR10], a

    ; Duty Cycle = 75%
    ld a, $C0
    ldh [rNR11], a

    ; Initial volume = A
    ld a, $A0
    ldh [rNR12], a

    ; Period = 96
    ld a, $A0
    ldh [rNR13], a

    ; Trigger = 1
    ld a, $87
    ldh [rNR14], a

    Wait 14290

    Wait 16384
    Wait 16384
    Wait 16384
    Wait 16384
    Wait 16384
    Wait 16384
    Wait 16384
    Wait 16384
    Wait 6

    ldh a, [rNR52]
    cp $f0

    jp nz, TestFail
    jp TestSuccess
