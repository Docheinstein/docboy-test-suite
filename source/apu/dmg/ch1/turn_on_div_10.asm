INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "apu.inc"
INCLUDE "print.inc"
INCLUDE "debug.inc"

; Check that CH1 length timer turns off CH1 with the correct timing.

EntryPoint:
    ; Reset DIV
    xor a
    ldh [rDIV], a

    ; Wait for DIV == 0x10
.WaitDiv
    ldh a, [rDIV]
    cp $10
    jr nz, .WaitDiv

    DisableAPU
    EnableAPU

    xor a
    ldh [rNR10], a

    ; Initial length = 4
    ld a, $3B
    ldh [rNR11], a

    ; Initial volume = F
    ld a, $F0
    ldh [rNR12], a

    ; Trigger = 1
    ; Length enable = 1
    ld a, $C0
    ldh [rNR14], a

    ld de, $00

StartLoop:
.loop
    ldh a, [rNR52]
    inc de
    and $01
    jr nz, .loop
EndLoop:
    ld a, d
    cp $05
    jp nz, TestFail
    ld a, e
    cp $fc
    jp nz, TestFail

    jp TestSuccess


