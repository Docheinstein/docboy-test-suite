INCLUDE "all.inc"

; Check what happens if period sweep step is changed from 7 to 0
; during a recalculation after a two triggers and then back to 7.

EntryPoint:
    ld hl, rNR10

    ; Pace = 1
    ; Direction = 0 (increase)
    ; Step = 7
    ld c, $17

    ; Pace = 1
    ; Direction = 0 (increase)
    ; Step = 0
    ld b, $10

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
    ; Step = 7
    ld a, $17
    ldh [rNR10], a

    ; Duty Cycle = 75%
    ld a, $C0
    ldh [rNR11], a

    ; Initial volume = A
    ld a, $A0
    ldh [rNR12], a

    ; Period = 15
    ld a, $F1
    ldh [rNR13], a

    ; Trigger = 1
    ld a, $87
    ldh [rNR14], a

    Nops 2

    ld [hl], b

    Wait 255

    ld [hl], c

    Nops 10

    ldh a, [rNR52]
    cp $f0

    jp nz, TestFail
    jp TestSuccess
