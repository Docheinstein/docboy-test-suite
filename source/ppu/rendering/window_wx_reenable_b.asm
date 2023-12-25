INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "vram.inc"

; Render with window enabled, turn it off and reenable it again.

EntryPoint:
    ; Disable PPU
    DisablePPU

    ; Set BGP
    ld a, %11100100
    ldh [rBGP], a

    ; Set WY
    ld a, 8
    ldh [rWY], a

    ; Set WX=15
    ld a, 15
    ldh [rWX], a

    ; Reset VRAM
    ResetVRAM

    ; Place 32 tiles to VRAM Tile Data[1]
    ; Memset $9010, $ff, $0200
    Memcpy $9010, VramTileData, VramTileDataEnd - VramTileData

    ; Write Indexes 1:32 to VRAM Tile Map[0]
    Memcpy $9C00, VramTileMapData, VramTileMapDataEnd - VramTileMapData

Loop:
    ; Enable PPU with window on
    ld a, LCDCF_ON | LCDCF_BGON | LCDCF_WINON | LCDCF_WIN9C00
    ldh [rLCDC], a

    WaitScanline 12

    ; Wait so that a part of the window is render.
    Nops 21

    ; Disable window
    ld a, LCDCF_ON | LCDCF_BGON | LCDCF_WIN9C00
    ldh [rLCDC], a

    Nops 6

    ; Enable PPU with window on
    ld a, LCDCF_ON | LCDCF_BGON | LCDCF_WINON | LCDCF_WIN9C00
    ldh [rLCDC], a

    WaitVBlank

    jp Loop


VramTileData:
    db $67, $b9, $ff, $ff, $67, $b9, $ff, $ff, $67, $b9, $ff, $ff, $67, $b9, $ff, $ff
    db $8f, $f1, $ff, $ff, $8f, $f1, $ff, $ff, $8f, $f1, $ff, $ff, $8f, $f1, $ff, $ff
    db $c3, $fc, $ff, $ff, $c3, $fc, $ff, $ff, $c3, $fc, $ff, $ff, $c3, $fc, $ff, $ff
    db $fc, $3f, $ff, $ff, $fc, $3f, $ff, $ff, $fc, $3f, $ff, $ff, $fc, $3f, $ff, $ff
    db $1f, $e0, $ff, $ff, $1f, $e0, $ff, $ff, $1f, $e0, $ff, $ff, $1f, $e0, $ff, $ff
    db $f8, $ff, $ff, $ff, $f8, $ff, $ff, $ff, $f8, $ff, $ff, $ff, $f8, $ff, $ff, $ff
    db $1f, $e0, $ff, $ff, $1f, $e0, $ff, $ff, $1f, $e0, $ff, $ff, $1f, $e0, $ff, $ff
    db $fe, $7f, $ff, $ff, $fe, $7f, $ff, $ff, $fe, $7f, $ff, $ff, $fe, $7f, $ff, $ff
    db $03, $fc, $ff, $ff, $03, $fc, $ff, $ff, $03, $fc, $ff, $ff, $03, $fc, $ff, $ff
    db $ff, $07, $ff, $ff, $ff, $07, $ff, $ff, $ff, $07, $ff, $ff, $ff, $07, $ff, $ff
    db $f0, $ff, $ff, $ff, $f0, $ff, $ff, $ff, $f0, $ff, $ff, $ff, $f0, $ff, $ff, $ff
    db $0f, $f0, $ff, $ff, $0f, $f0, $ff, $ff, $0f, $f0, $ff, $ff, $0f, $f0, $ff, $ff
    db $ff, $0f, $ff, $ff, $ff, $0f, $ff, $ff, $ff, $0f, $ff, $ff, $ff, $0f, $ff, $ff
    db $f0, $ff, $ff, $ff, $f0, $ff, $ff, $ff, $f0, $ff, $ff, $ff, $f0, $ff, $ff, $ff
    db $07, $f8, $ff, $ff, $07, $f8, $ff, $ff, $07, $f8, $ff, $ff, $07, $f8, $ff, $ff
    db $fc, $03, $ff, $ff, $fc, $03, $ff, $ff, $fc, $03, $ff, $ff, $fc, $03, $ff, $ff
VramTileDataEnd:


VramTileMapData:
    db $01, $02, $03, $04, $05, $06, $07, $08, $09, $0a, $0b, $0c, $0d, $0e, $0f, $10, $11, $12
VramTileMapDataEnd: