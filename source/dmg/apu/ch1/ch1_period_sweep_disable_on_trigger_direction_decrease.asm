INCLUDE "all.inc"

; Check if channel is disabled due to period sweep timing overflow if direction is decrease.

EntryPoint:
    xor a
    ldh [rDIV], a

    DisableAPU
    EnableAPU

    ; Pace = 3
    ; Direction = 1 (decrease)
    ; Step = 6
    ld a, $3E
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

REPT 32
    Wait 16384
ENDR

    ldh a, [rNR52]
    cp $f1

    jp nz, TestFail
    jp TestSuccess
