INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "vram.inc"

; Render with window enabled but move WX forward during Pixel Transfer.

EntryPoint:
    ; Disable PPU
    DisablePPU

    ; Set BGP
    ld a, %11100100
    ldh [rBGP], a

    ; Set WY
    ld a, 8
    ldh [rWY], a

    ; Reset VRAM
    ResetVRAM

    ; Place 32 tiles to VRAM Tile Data[1]
    ; Memset $9010, $ff, $0200
    Memcpy $9010, VramTileData, VramTileDataEnd - VramTileData

    ; Write Indexes 1:32 to VRAM Tile Map[0]
    Memcpy $9C00, VramTileMapData, VramTileMapDataEnd - VramTileMapData

    ; Enable PPU with window on
    ld a, LCDCF_ON | LCDCF_BGON | LCDCF_WINON | LCDCF_WIN9C00
    ldh [rLCDC], a

Loop:
    ; Set WX
    ld a, 15
    ldh [rWX], a

    WaitScanline 12

    ; Should render last 4 lines of window tile with WX=63
    ; Nops 9 -> BGB still flickr, Gambatte is ok
    Nops 8

    ; Set WX
    ld a, 63
    ldh [rWX], a

    WaitVBlank

    jp Loop


VramTileData:
    db $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
VramTileDataEnd:


VramTileMapData:
    db $01, $02, $03, $04
VramTileMapDataEnd: