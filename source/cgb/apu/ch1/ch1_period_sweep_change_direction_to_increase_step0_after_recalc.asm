INCLUDE "all.inc"

; Check when CH1 is disabled if direction is changed from decreasing to increasing
; with step 0 after a recalculation happened.

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

    ; Period = 1280
    ld a, $00
    ldh [rNR13], a

    ; Trigger = 1
    ld a, $83
    ldh [rNR14], a

    Wait 8192
    Wait 8192

    ; Pace = 2
    ; Direction = 0 increase
    ; Step = 0
    ld a, $20
    ldh [rNR10], a

    ldh a, [rNR52]
    cp $f0

    jp nz, TestFail
    jp TestSuccess
