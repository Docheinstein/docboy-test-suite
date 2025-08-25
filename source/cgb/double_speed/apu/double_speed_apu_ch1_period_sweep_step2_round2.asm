INCLUDE "all.inc"

; Check when CH1 is disabled due to period sweep timing overflow with step 2.

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

    ; Pace = 3
    ; Direction = 0 (increase)
    ; Step = 2
    ld a, $32
    ldh [rNR10], a

    ; Duty Cycle = 75%
    ld a, $C0
    ldh [rNR11], a

    ; Initial volume = A
    ld a, $A0
    ldh [rNR12], a

    ; Period = 512
    ld a, $00
    ldh [rNR13], a

    ; Trigger = 1
    ld a, $86
    ldh [rNR14], a

    Wait 45019

    ldh a, [rNR52]
    cp $f0

    jp nz, TestFail
    jp TestSuccess
