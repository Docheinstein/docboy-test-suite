INCLUDE "all.inc"

; Check what happens if NR13 (period low) is changed during a recalculation.

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
    Wait 14285

    ; Period =
    ld a, $20
    ldh [rNR13], a

    Wait 212995

    ldh a, [rNR52]
    cp $f1

    jp nz, TestFail
    jp TestSuccess
