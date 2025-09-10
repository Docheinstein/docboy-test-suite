INCLUDE "all.inc"

; Check what happens if period is changed with a retrigger at the same time recalculation happens.

EntryPoint:
    xor a
    ldh [rDIV], a

    DisableAPU

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Switch to double speed
    stop

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

    ; Period = 1025
    ld a, $FF
    ldh [rNR13], a

    ; Trigger = 1
    ld a, $83
    ldh [rNR14], a

    Wait 16384
    Wait 16384
    Wait 16384
    Wait 16384
    Wait 16384

    Wait 12228

    ; Trigger = 1
    ld a, $87
    ldh [rNR14], a

    Wait 14

    ldh a, [rNR52]
    cp $f1

    jp nz, TestFail
    jp TestSuccess
