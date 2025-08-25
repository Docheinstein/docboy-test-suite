INCLUDE "all.inc"

; Check when CH1 is disabled if direction is changed from decreasing to increasing
; with different step/period values.

EntryPoint:
    xor a
    ldh [rDIV], a

    DisableAPU
    EnableAPU

    ; Pace = 2
    ; Direction = 1 (decrease)
    ; Step = 6
    ld a, $2E
    ldh [rNR10], a

    ; Duty Cycle = 75%
    ld a, $C0
    ldh [rNR11], a

    ; Initial volume = A
    ld a, $A0
    ldh [rNR12], a

    ; Period = 256
    ld a, $00
    ldh [rNR13], a

    ; Trigger = 1
    ld a, $87
    ldh [rNR14], a

    Wait 4

    ; Pace = 2
    ; Direction = 0 (increase)
    ; Step = 6
    ld a, $26
    ldh [rNR10], a

    ldh a, [rNR52]
    cp $f0

    jp nz, TestFail
    jp TestSuccess
