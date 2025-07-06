INCLUDE "all.inc"

; Check the square wave position of channel 1 for a duty cycle of 12.5%.

EntryPoint:
    xor a
    ldh [rDIV], a

    DisableAPU
    EnableAPU

    xor a
    ldh [rNR10], a

    ; Duty Cycle = 12.5%
    ld a, $00
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

    Nops 11

    ldh a, [rPCM12]
    cp $00

    jp nz, TestFail
    jp TestSuccess
