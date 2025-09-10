INCLUDE "all.inc"

; Check what happens if NR13 (period low) is changed while period sweep is active.

EntryPoint:
    xor a
    ldh [rDIV], a

    DisableAPU
    EnableAPU

    ; Pace = 1
    ; Direction = 0 (increase)
    ; Step = 6
    ld a, $16
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

    Wait 4096
    Wait (2000 - 16)

    ; Period = 80
    ld a, $B0
    ldh [rNR13], a

    ; (Period sweep ticks around here)

    Nops 123

    ldh a, [rPCM12]
    cp $00

    jp nz, TestFail
    jp TestSuccess
