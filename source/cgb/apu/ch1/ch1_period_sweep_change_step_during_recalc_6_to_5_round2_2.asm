INCLUDE "all.inc"

; Check what happens if period sweep step is changed from 6 to 5
; during a period sweep tick.

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

    ; Period = 65
    ld a, $BF
    ldh [rNR13], a

    ; Trigger = 1
    ld a, $87
    ldh [rNR14], a

    Wait 22479

    ; Pace = 3
    ; Direction = 0 (increase)
    ; Step = 5
    ld a, $35
    ldh [rNR10], a

    Wait 24578

    ldh a, [rNR52]
    cp $f0

    jp nz, TestFail
    jp TestSuccess
