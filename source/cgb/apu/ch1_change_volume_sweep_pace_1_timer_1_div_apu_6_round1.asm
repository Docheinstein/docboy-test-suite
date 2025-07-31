INCLUDE "all.inc"

; Change CH1 volume sweep while it is running (without retrigger) with various timing.

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
    ; Sweep = 0
    ld a, $A8
    ldh [rNR12], a

    ; Period = 16
    ld a, $F0
    ldh [rNR13], a

    ; Trigger = 1
    ld a, $87
    ldh [rNR14], a

    Wait 16384
    Wait 10240

    ; Initial volume = A
    ; Envelope direction = 1
    ; Sweep = 1
    ld a, $A9
    ldh [rNR12], a

    Wait 30720

    Wait 32768
    Wait 32768

    Wait 8139

    ldh a, [rPCM12]
    cp $0b

    jp nz, TestFail
    jp TestSuccess
