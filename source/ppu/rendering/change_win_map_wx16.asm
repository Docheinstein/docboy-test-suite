INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "vram.inc"
INCLUDE "dma.inc"

; Change LCDC window tile map bit during pixel transfer at different fetcher phases.

EntryPoint:
    ; Disable PPU
    DisablePPU

    ; Set BGP
    ld a, %11100100
    ldh [rBGP], a

    ; Set WY
    ld a, 8
    ldh [rWY], a

    ; Set WX
    ld a, 16
    ldh [rWX], a

    ; Set SCX
    ld a, 0
    ldh [rSCX], a

    ; Reset VRAM and OAM
    ResetVRAM

    ; Set VRAM data
    Memcpy $9000, VramTileData, VramTileDataEnd - VramTileData
    Memcpy $9800, WindowVramTileMapData9800, WindowVramTileMapData9800End - WindowVramTileMapData9800
    Memcpy $9C00, WindowVramTileMapData9C00, WindowVramTileMapData9C00End - WindowVramTileMapData9C00

    ld b, LCDCF_ON | LCDCF_BGON | LCDCF_WINON | LCDCF_WIN9800
    ld c, LCDCF_ON | LCDCF_BGON | LCDCF_WINON | LCDCF_WIN9C00
    ld hl, $ff40

    ; Enable PPU
    ld [hl], b

    ; Wait for the next frame
    LongWait 114 * 154
    LongWait 114 * 8

    Nops 26

    ; Change window tilemap and switch it back to the default again
    ld [hl], c
    ld [hl], b

    WaitVBlank

    ; Soft Breakpoint: good time to take a screenshot
    ld b, b

    halt
    nop

VramTileData:
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00,
    db $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
VramTileDataEnd:

WindowVramTileMapData9800:
    db $01, $01, $01, $01, $01, $01, $01, $01
WindowVramTileMapData9800End:

WindowVramTileMapData9C00:
    db $02, $02, $02, $02, $02, $02, $02, $02,
WindowVramTileMapData9C00End:
