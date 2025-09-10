INCLUDE "all.inc"

; Change the duty cycle from 75% to 50% with various delays and check the output.

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

    ; Initial volume = F
    ld a, $F0
    ldh [rNR12], a

    ; Period = 1
    ld a, $FF
    ldh [rNR13], a

    ; Trigger = 1
    ld a, $87
    ldh [rNR14], a

    Nops 4

    ; Duty Cycle = 50%
    ld a, $80
    ldh [rNR11], a

    Nops 6

    ldh a, [rPCM12]
    cp $0f

    jp nz, TestFail
    jp TestSuccess
