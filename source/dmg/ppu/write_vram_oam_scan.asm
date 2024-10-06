INCLUDE "hardware.inc"
INCLUDE "common.inc"

EntryPoint:
    WaitVBlank

    ; Write something to VRAM
    ld a, $01
    ld hl, $8000 ; VRAM
    ld [hl], a

    ; Wait oam scan
    WaitMode 2

    ; Try to write something to VRAM
    ld a, $02
    ld [hl], a

    WaitVBlank

    ; Read it back
    ld hl, $8000 ; VRAM
    ld a, [hl]
    ld b, a

    ; Check result
    ld a, $02
    cp b
    jp nz, TestFail

    jp TestSuccess