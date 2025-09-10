INCLUDE "all.inc"

; Check what happens if period is changed without a retrigger at the same time recalculation happens.

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
    Wait 16384
    Wait 16384
    Wait 16384

    Wait 12243

    ; Trigger = 0
    ld a, $07
    ldh [rNR14], a

    Wait 425993

    ldh a, [rNR52]
    cp $f0

    jp nz, TestFail
    jp TestSuccess
