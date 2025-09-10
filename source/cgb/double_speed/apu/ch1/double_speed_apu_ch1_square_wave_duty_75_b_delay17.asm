INCLUDE "all.inc"

; Check the square wave position of channel 1 for a duty cycle of 75% with various alignment of PPU on/CH trigger.

EntryPoint:
    xor a
    ldh [rDIV], a

    DisableAPU

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Switch to double speed
    stop

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

    Nops 1

    ; Trigger = 1
    ld a, $87
    ldh [rNR14], a

    Nops 17

    ldh a, [rPCM12]
    cp $00

    jp nz, TestFail
    jp TestSuccess
