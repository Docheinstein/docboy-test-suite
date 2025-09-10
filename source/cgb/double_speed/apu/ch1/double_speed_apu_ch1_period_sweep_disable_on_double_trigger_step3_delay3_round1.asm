INCLUDE "all.inc"

; Check when CH1 is disabled if channel is triggered twice with step 3.

EntryPoint:
    ld hl, rNR14

    xor a
    ldh [rDIV], a

    DisableAPU

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Switch to double speed
    stop

    EnableAPU

    ; Pace = 2
    ; Direction = 0 (increase)
    ; Step = 3
    ld a, $23
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

    Nops 3

    ld [hl], a

    Nops 7

    ldh a, [rNR52]
    cp $f1

    jp nz, TestFail
    jp TestSuccess
