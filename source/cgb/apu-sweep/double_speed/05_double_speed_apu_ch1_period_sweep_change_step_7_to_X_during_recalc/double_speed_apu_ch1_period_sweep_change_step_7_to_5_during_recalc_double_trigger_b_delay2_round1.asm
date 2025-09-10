INCLUDE "all.inc"

; Check what happens if period sweep step is changed from 7 to 5
; during a recalculation.

EntryPoint:
    ; Pace = 1
    ; Direction = 0 (increase)
    ; Step = 5
    ld hl, rNR10
    ld b, $15

    ld de, rNR14

    xor a
    ldh [rDIV], a

    DisableAPU

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Switch to double speed
    stop

    EnableAPU

    Nops 1

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
    ld [de], a
    ld [hl], b

    Wait 9

    ldh a, [rNR52]
    cp $f1

    jp nz, TestFail
    jp TestSuccess
