INCLUDE "all.inc"

; Check the square wave position of channel 1 for a duty cycle of 75% with various alignment of PPU on/CH trigger.

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

    Nops 12

    ldh a, [rPCM12]
    cp $0F

    jp nz, TestFail
    jp TestSuccess
