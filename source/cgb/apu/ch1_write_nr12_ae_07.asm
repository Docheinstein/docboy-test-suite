INCLUDE "all.inc"

; Change NR12 value while CH1 is running with various previous/after values and check how this affects volume (NRx2 glitch).

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

    ; Initial volume = a
    ; Envelope direction = 1
    ; Sweep =  6
    ld a, $ae
    ldh [rNR12], a

    ; Period = 16
    ld a, $F0
    ldh [rNR13], a

    ; Trigger = 1
    ld a, $87
    ldh [rNR14], a

    Wait 16384 * 4

    Nops 16

    ; Initial volume = 0
    ; Envelope direction = 0
    ; Sweep =  7
    ld a, $07
    ldh [rNR12], a

    Nops 32

    ldh a, [rPCM12]
    DumpRegisters

    jp nz, TestFail
    jp TestSuccess
