INCLUDE "all.inc"

; Check when CH1 is disabled if direction is changed from decreasing to increasing
; with step 0 just after the trigger.

EntryPoint:
    xor a
    ldh [rDIV], a

    DisableAPU
    EnableAPU

    ; Pace = 2
    ; Direction = 1 (decrease)
    ; Step = 0
    ld a, $28
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

    ; Trigger = 1
    ld a, $87
    ldh [rNR14], a

    ; Pace = 2
    ; Direction = 0 increase
    ; Step = 0
    ld a, $20
    ldh [rNR10], a

    Wait 14283

    ldh a, [rNR52]
    cp $f1

    jp nz, TestFail
    jp TestSuccess
