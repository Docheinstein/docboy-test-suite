INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Check the value of STAT after PPU is turned on with LYC=1.

EntryPoint:
    WaitVBlank

    ; Write something to VRAM
    ld a, $01
    ld hl, $8000 ; VRAM
    ld [hl], a

    ; Wait pixel transfer
    WaitMode 3

    ; Try to write something to VRAM
    ld a, $02
    ld [hl], a

    WaitVBlank

    ; Read it back
    ld hl, $8000 ; VRAM
    ld a, [hl]
    ld b, a

    ; Check result
    ld a, $01
    cp b
    jp nz, TestFail

    jp TestSuccess