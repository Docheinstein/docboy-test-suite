INCLUDE "all.inc"

; Read output of channel 1 when APU is shut down at various square wave position.

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

    DisableAPU

    ldh a, [rPCM12]
    cp $00

    jp nz, TestFail
    jp TestSuccess
