INCLUDE "all.inc"

; Check when CH1 is disabled if direction is changed from increasing to decreasing
; after a NR14 trigger.

EntryPoint:
    ; Pace = 2
    ; Direction = 1 (decrease)
    ; Step = 6
    ld hl, rNR10
    ld b, $2E

    xor a
    ldh [rDIV], a

    DisableAPU
    EnableAPU

    ; Pace = 2
    ; Direction = 0 (increase)
    ; Step = 6
    ld a, $26
    ldh [rNR10], a

    ; Duty Cycle = 75%
    ld a, $C0
    ldh [rNR11], a

    ; Initial volume = A
    ld a, $A0
    ldh [rNR12], a

    ; Period = 16
    ld a, $F0
    ldh [rNR13], a

    ; Trigger = 1
    ld a, $87
    ldh [rNR14], a

    Wait 7

    ; Pace = 2
    ; Direction = 1 (decrease)
    ; Step = 6
    ld [hl], b

    ldh a, [rNR52]
    cp $f0

    jp nz, TestFail
    jp TestSuccess
