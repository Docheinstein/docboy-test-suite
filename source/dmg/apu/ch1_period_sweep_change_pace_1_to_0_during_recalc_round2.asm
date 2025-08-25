INCLUDE "all.inc"

; Check what happens if period sweep pace is changed from 1 to 0
; during a recalculation.

EntryPoint:
    xor a
    ldh [rDIV], a

    DisableAPU
    EnableAPU

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

    ; Period = 16
    ld a, $F0
    ldh [rNR13], a

    ; Trigger = 1
    ld a, $87
    ldh [rNR14], a

    Wait 6094

    ; Pace = 0
    ; Direction = 0 (increase)
    ; Step = 7
    ld a, $07
    ldh [rNR10], a

    ldh a, [rNR52]
    cp $f0

    jp nz, TestFail
    jp TestSuccess
