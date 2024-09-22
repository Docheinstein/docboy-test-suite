INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "apu.inc"

; Check the timing of CH1's square wave position.
; Uses PCM (CGB only).

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
    Nops 20

    ; Retrigger

    ; Trigger = 1
    ; Length enable = 1
    ld a, $CF
    ldh [rNR24], a

    Nops 18

    ; Read PCMs
    ldh a, [rPCM34]
    ld b, a

    ldh a, [rPCM12]

    ; Check PCM12
    cp $00
    jp nz, TestFail

    ; Check PCM34
    ld a, b
    cp $00
    jp nz, TestFail

    jp TestSuccess