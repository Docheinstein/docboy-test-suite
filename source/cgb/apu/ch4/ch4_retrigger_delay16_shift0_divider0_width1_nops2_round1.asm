INCLUDE "all.inc"

; Check the timing of CH4 when the channel is retriggered (once) while it's active.

EntryPoint:
    ; Reset DIV
    xor a
    ldh [rDIV], a
    ld hl, rPCM34

    DisableAPU
    EnableAPU

    Nops 2

    ld a, $F0
    ldh [rNR42], a

    ; Clock shift = 0
    ; LFSR width = 1 (7 bit)
    ; Clock divider = 0
    ld a, $08
    ldh [rNR43], a

    ; Trigger = 1
    ld a, $80
    ldh [rNR44], a

    Nops 16

    ldh [rNR44], a

    Wait 16

    ld a, [hl]
    cp $00
    ; 00

    jp nz, TestFail
    jp TestSuccess