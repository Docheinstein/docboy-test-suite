INCLUDE "all.inc"

; Check when CH1 is disabled if direction is changed from increasing to decreasing
; during a recalculation.

EntryPoint:
    xor a
    ldh [rDIV], a

    DisableAPU
    EnableAPU

    ; Pace = 3
    ; Direction = 0 (increase)
    ; Step = 6
    ld a, $36
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

    Wait 14290

    Wait 16384
    Wait 16384
    Wait 16384
    Wait 8192
    Wait 2

    ; Pace = 3
    ; Direction = 1 (decrease)
    ; Step = 6
    ld a, $3E
    ldh [rNR10], a

REPT 16
    Wait 16384
ENDR

    ldh a, [rNR52]
    cp $f1

    jp nz, TestFail
    jp TestSuccess
