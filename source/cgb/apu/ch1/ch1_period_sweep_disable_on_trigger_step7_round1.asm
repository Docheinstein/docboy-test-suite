INCLUDE "all.inc"

; Check when CH1 is disabled on trigger with step 7.

EntryPoint:
    xor a
    ldh [rDIV], a

    DisableAPU
    EnableAPU

    ; Pace = 2
    ; Direction = 0 (increase)
    ; Step = 7
    ld a, $27
    ldh [rNR10], a

    ; Duty Cycle = 75%
    ld a, $C0
    ldh [rNR11], a

    ; Initial volume = A
    ld a, $A0
    ldh [rNR12], a

    ; Period = 8
    ld a, $F8
    ldh [rNR13], a

    ; Trigger = 1
    ld a, $87
    ldh [rNR14], a

    Wait 6

    ldh a, [rNR52]
    cp $f1

    jp nz, TestFail
    jp TestSuccess
