INCLUDE "all.inc"

; Change CH1 initial volume while channel is running (without retrigger).

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
    ; Envelope direction = 1
    ; Sweep = 1
    ld a, $A9
    ldh [rNR12], a

    ; Period = 16
    ld a, $F0
    ldh [rNR13], a

    ; Trigger = 1
    ld a, $87
    ldh [rNR14], a

    ; Tick volume sweep
    Wait 16384 * 2

    Nops 16

    ; Initial volume = 8
    ; Envelope direction = 1
    ; Sweep = 1
    ld a, $89
    ldh [rNR12], a

    ; Tick volume sweep
    Wait 16384 * 2

    ldh a, [rPCM12]
    cp $0e

    jp nz, TestFail
    jp TestSuccess
