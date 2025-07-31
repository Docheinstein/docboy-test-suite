INCLUDE "all.inc"

; Change CH1 initial volume while channel is running and retrigger.

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
    ; Envelope direction = 0
    ; Sweep = 0
    ld a, $A0
    ldh [rNR12], a

    ; Period = 16
    ld a, $F0
    ldh [rNR13], a

    ; Trigger = 1
    ld a, $87
    ldh [rNR14], a

    Nops 16

    ; Initial volume = A
    ; Envelope direction = 0
    ; Sweep = 0
    ld a, $B1
    ldh [rNR12], a

    Nops 32

    ; Trigger = 1
    ld a, $87
    ldh [rNR14], a

    ldh a, [rPCM12]
    cp $0b

    jp nz, TestFail
    jp TestSuccess
