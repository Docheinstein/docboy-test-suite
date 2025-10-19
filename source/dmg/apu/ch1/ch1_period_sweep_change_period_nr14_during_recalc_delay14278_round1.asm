INCLUDE "all.inc"

; Check what happens if period is changed with a retrigger at the same time recalculation happens.

EntryPoint:
    xor a
    ldh [rDIV], a

    DisableAPU
    EnableAPU

    ; Pace = 1
    ; Direction = 0 (increase)
    ; Step = 5
    ld a, $15
    ldh [rNR10], a

    ; Duty Cycle = 75%
    ld a, $C0
    ldh [rNR11], a

    ; Initial volume = A
    ld a, $A0
    ldh [rNR12], a

    ; Period = 1280
    ld a, $00
    ldh [rNR13], a

    ; Trigger = 1
    ld a, $83
    ldh [rNR14], a

    Wait 16384
    Wait 16384
    Wait 14278

    ; Trigger = 1
    ld a, $87
    ldh [rNR14], a

    Wait 8202

    ldh a, [rNR52]
    cp $f1

    jp nz, TestFail
    jp TestSuccess
