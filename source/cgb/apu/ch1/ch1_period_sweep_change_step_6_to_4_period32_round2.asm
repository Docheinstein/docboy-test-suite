INCLUDE "all.inc"

; Check what happens if period sweep step is changed from 6 to 4
; with various period values.

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

    ; Period = 32
    ld a, $E0
    ldh [rNR13], a

    ; Trigger = 1
    ld a, $87
    ldh [rNR14], a

    Wait 16

    ; Pace = 3
    ; Direction = 0 (increase)
    ; Step = 4
    ld a, $34
    ldh [rNR10], a

    Wait 22464

    ldh a, [rNR52]
    cp $f0

    jp nz, TestFail
    jp TestSuccess
