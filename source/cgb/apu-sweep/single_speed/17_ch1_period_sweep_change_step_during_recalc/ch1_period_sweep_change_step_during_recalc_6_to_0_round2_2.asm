INCLUDE "all.inc"

; Check what happens if period sweep step is changed from 6 to 0
; during a period sweep tick.

EntryPoint:
    xor a
    ldh [rDIV], a

    DisableAPU
    EnableAPU

    ; Pace = 2
    ; Direction = 0 (increase)
    ; Step = 6
    ld a, $26
    ldh [rNR10], a

    ; Duty Cycle = 75%
    ld a, $C0
    ldh [rNR11], a

    ; Initial volume = A
    ld a, $A0
    ldh [rNR12], a

    ; Period = 12800
    ld a, $00
    ldh [rNR13], a

    ; Trigger = 1
    ld a, $83
    ldh [rNR14], a

    Wait 14286

    ; Pace = 2
    ; Direction = 0 (increase)
    ; Step = 0
    ld a, $30
    ldh [rNR10], a

    Wait 4872

    ldh a, [rPCM12]
    cp $00

    jp nz, TestFail
    jp TestSuccess
