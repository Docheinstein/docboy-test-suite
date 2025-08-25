INCLUDE "all.inc"

; Check what happens if period sweep pace is changed from 0 to 4
; and then step is changed from 0 to 2.

EntryPoint:
    ld hl, rNR10

    xor a
    ldh [rDIV], a

    DisableAPU
    EnableAPU

    ; Pace = 0
    ; Direction = 0 (increase)
    ; Step = 0
    ld a, $00
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

    Wait 16

    ; Pace = 2
    ; Direction = 0 (increase)
    ; Step = 0
    ld a, $20
    ld [hl], a

    ; Pace = 2
    ; Direction = 0 (increase)
    ; Step = 4
    ld a, $24
    ld [hl], a

    Wait 79804

    ldh a, [rNR52]
    cp $f1

    jp nz, TestFail
    jp TestSuccess
