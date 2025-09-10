INCLUDE "all.inc"

; Check timing of CH1 period sweep's period writeback with pace 1 and step 0.

EntryPoint:
    xor a
    ldh [rDIV], a

    DisableAPU
    EnableAPU

    ; Pace = 1
    ; Direction = 0 (increase)
    ; Step = 0
    ld a, $10
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

REPT 32
    Wait 16384
ENDR

    ldh a, [rPCM12]
    cp $0a

    jp nz, TestFail
    jp TestSuccess
