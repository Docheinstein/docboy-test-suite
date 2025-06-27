INCLUDE "all.inc"

; Check the timing of CH2's square wave position.

EntryPoint:
    DisableAPU
    EnableAPU

    ; Initial length = 1
    ld a, $01
    ldh [rNR21], a

    ; Initial volume = F
    ld a, $F0
    ldh [rNR22], a

    ; Period = 0x7FD
    ld a, $FD
    ldh [rNR23], a

    ; Trigger = 1
    ; Length enable = 1
    ld a, $CF
    ldh [rNR24], a

    ; Wait
    Nops 41

    ; Read PCMs
    ldh a, [rPCM34]
    ld b, a

    ldh a, [rPCM12]

    ; Check PCM12
    cp $F0
    jp nz, TestFail

    ; Check PCM34
    ld a, b
    cp $00
    jp nz, TestFail

    jp TestSuccess