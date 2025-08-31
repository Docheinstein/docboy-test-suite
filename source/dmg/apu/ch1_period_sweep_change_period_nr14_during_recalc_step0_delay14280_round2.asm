INCLUDE "all.inc"

; Check what happens if period is changed with a retrigger at the same time recalculation happens.

EntryPoint:
    xor a
    ldh [rDIV], a

    DisableAPU
    EnableAPU

    ; Pace = 1
    ; Direction = 0 (increase)
    ; Step = 0
    ld a, $10
    ldh [rNR10], a

    ; Duty Cycle = 75%
    ld a, $C0
    ldh [rNR11], a

    ; Initial volume = A
    ld a, $A0
    ldh [rNR12], a

    ; Period = 96
    ld a, $FF
    ldh [rNR13], a

    ; Trigger = 1
    ld a, $83
    ldh [rNR14], a

    Wait 14280

    ; Trigger = 1
    ld a, $87
    ldh [rNR14], a

    Wait 4

    ldh a, [rNR52]
    cp $f0

    jp nz, TestFail
    jp TestSuccess
