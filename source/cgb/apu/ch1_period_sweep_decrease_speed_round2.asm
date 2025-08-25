INCLUDE "all.inc"

; Check that period sweep behaves correctly with decreasing direction.

EntryPoint:
    xor a
    ldh [rDIV], a

    DisableAPU
    EnableAPU

    ; Pace = 1
    ; Direction = 1 (decrease)
    ; Step = 7
    ld a, $1F
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

    Wait 8192
    Wait 8192
    Wait 8192
    Wait 8192
    Wait 8192
    Wait 8192

    Wait 265

    ldh a, [rPCM12]
    cp $00

    jp nz, TestFail
    jp TestSuccess
