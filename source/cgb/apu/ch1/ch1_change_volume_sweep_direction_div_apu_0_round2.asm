INCLUDE "all.inc"

; Change CH1 volume sweep direction while it is running (without retrigger).

EntryPoint:
    xor a
    ldh [rDIV], a

    DisableAPU
    EnableAPU

    xor a
    ldh [rNR10], a

    ; Duty Cycle = 75%
    ld a, $C0
    ldh [rNR11], a

    ; Initial volume = A
    ; Envelope direction = 1 (increase)
    ; Sweep = 1
    ld a, $A9
    ldh [rNR12], a

    ; Period = 16
    ld a, $F0
    ldh [rNR13], a

    ; Trigger = 1
    ld a, $87
    ldh [rNR14], a

    Wait 2048 * 7

    ; Initial volume = A
    ; Envelope direction = 0 (decrease)
    ; Sweep = 1
    ld a, $A1
    ldh [rNR12], a

    Wait 1996

    ldh a, [rPCM12]
    cp $05

    jp nz, TestFail
    jp TestSuccess
