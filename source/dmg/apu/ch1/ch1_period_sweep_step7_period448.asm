INCLUDE "all.inc"

; Check when CH1 is disabled due to period sweep timing overflow with step 7.

EntryPoint:
    xor a
    ldh [rDIV], a

    DisableAPU
    EnableAPU

    ; Pace = 1
    ; Direction = 0 (increase)
    ; Step = 7
    ld a, $17
    ldh [rNR10], a

    ; Duty Cycle = 75%
    ld a, $C0
    ldh [rNR11], a

    ; Initial volume = A
    ld a, $A0
    ldh [rNR12], a

    ; Period = 448
    ld a, $40
    ldh [rNR13], a

    ; Trigger = 1
    ld a, $86
    ldh [rNR14], a

    ld de, $0000
Loop:
    inc de
    ldh a, [rNR52]
    cp $f1
    jp z, Loop

    ld a, d
    cp $5c
    jp nz, TestFail

    ld a, e
    cp $5a
    jp nz, TestFail

    jp TestSuccess