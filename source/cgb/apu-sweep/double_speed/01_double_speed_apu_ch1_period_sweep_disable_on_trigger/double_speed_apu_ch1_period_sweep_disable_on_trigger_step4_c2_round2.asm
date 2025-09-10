INCLUDE "all.inc"

; Check when CH1 is disabled on trigger with step 4.

EntryPoint:
    xor a
    ldh [rDIV], a

    DisableAPU

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Switch to double speed
    stop

    Wait 1

    xor a
    ldh [rDIV], a

    EnableAPU

    ; Pace = 2
    ; Direction = 0 (increase)
    ; Step = 4
    ld a, $24
    ldh [rNR10], a

    ; Duty Cycle = 75%
    ld a, $C0
    ldh [rNR11], a

    ; Initial volume = A
    ld a, $A0
    ldh [rNR12], a

    ; Period = 96
    ld a, $A0
    ldh [rNR13], a

    Wait 1

    ; Trigger = 1
    ld a, $87
    ldh [rNR14], a

    Wait 10

    ldh a, [rNR52]
    cp $f0

    jp nz, TestFail
    jp TestSuccess
