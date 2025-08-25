INCLUDE "all.inc"

; Check what happens if period sweep step is changed from 7 to 0
; during a recalculation.

EntryPoint:
    ; Pace = 1
    ; Direction = 0 (increase)
    ; Step = 0
    ld hl, rNR10
    ld b, $10

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

    ; Period = 12800
    ld a, $F1
    ldh [rNR13], a

    ; Trigger = 1
    ld a, $87
    ldh [rNR14], a

    ld [hl], b

    Wait 6095

    ldh a, [rNR52]
    cp $f0

    jp nz, TestFail
    jp TestSuccess
