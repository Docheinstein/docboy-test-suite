INCLUDE "docboy.inc"

; Check that CH1 length timer turns off CH1 with the correct timing.

EntryPoint:
    ; Reset DIV
    xor a
    ldh [rDIV], a

    ; Wait for DIV == 0x0F
.WaitDiv
    ldh a, [rDIV]
    cp $0F
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

.loop
    ldh a, [rNR52]
    inc de
    and $01
    jr nz, .loop

    ld a, d
    cp $06
    jp nz, TestFail
    ld a, e
    cp $CF
    jp nz, TestFail

    jp TestSuccess