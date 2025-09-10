INCLUDE "all.inc"

; Check timing of CH1 period sweep's period writeback with pace 2.

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

    ; Period = 96
    ld a, $A0
    ldh [rNR13], a

    ; Trigger = 1
    ld a, $87
    ldh [rNR14], a

    Wait 4096
    Wait 8192
    Wait 2000

    ; (Period sweep ticks here)

    Nops 279

    ldh a, [rPCM12]
    cp $0a

    jp nz, TestFail
    jp TestSuccess
