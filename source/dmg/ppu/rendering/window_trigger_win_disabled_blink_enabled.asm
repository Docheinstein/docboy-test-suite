
INCLUDE "docboy.inc"

; Set WY=12, wait for line 11 than disable window before reaching line 12.
; Enable it again some time after during line 12.

EntryPoint:
    ; Disable PPU
    DisablePPU

    ; Set BGP
    ld a, %11100100
    ldh [rBGP], a

    ; Set WX=7
    ld a, 7
    ldh [rWX], a

    ; Set WY
    ld a, 12
    ldh [rWY], a

    ; Reset VRAM
    ; Reset VRAM
    Memset $8000, $00, $2000

    ; Set Window VRAM data
    Memcpy $9010, WindowVramTileData, WindowVramTileDataEnd - WindowVramTileData
    Memcpy $9C00, WindowVramTileMapData, WindowVramTileMapDataEnd - WindowVramTileMapData

    ; Enable PPU with window
    ld a, LCDCF_ON | LCDCF_BGON | LCDCF_WINON | LCDCF_WIN9C00
    ldh [rLCDC], a

Loop:
    ; Set WY
    ld a, 12
    ldh [rWY], a

    ; Wait HBlank of line 11
    WaitScanline 11
    WaitMode 0

    ; Disable window
    ld a, LCDCF_ON | LCDCF_BGON | LCDCF_WIN9C00
    ldh [rLCDC], a

    ; Wait HBlank of line 12
    WaitScanline 12
    WaitMode 0

    ; Blink it again
    ld a, LCDCF_ON | LCDCF_BGON | LCDCF_WINON | LCDCF_WIN9C00
    ldh [rLCDC], a
    ld a, LCDCF_ON | LCDCF_BGON  | LCDCF_WIN9C00
    ldh [rLCDC], a

    ; Wait line 13
    WaitScanline 13

    ; Enable window
    ld a, LCDCF_ON | LCDCF_BGON | LCDCF_WINON | LCDCF_WIN9C00
    ldh [rLCDC], a

    WaitVBlank

    jp Loop


WindowVramTileData:
    db $7f, $00, $ff, $01, $ff, $02, $ff, $03, $ff, $04, $ff, $05, $ff, $06, $ff, $07,
    db $7f, $08, $ff, $09, $ff, $0a, $ff, $0b, $ff, $0c, $ff, $0d, $ff, $0e, $ff, $0f,
    db $7f, $10, $ff, $11, $ff, $12, $ff, $13, $ff, $14, $ff, $15, $ff, $16, $ff, $17,
    db $7f, $18, $ff, $19, $ff, $1a, $ff, $1b, $ff, $1c, $ff, $1d, $ff, $1e, $ff, $1f,
WindowVramTileDataEnd:

WindowVramTileMapData:
    db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01,
    db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01,
    db $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02,
WindowVramTileMapDataEnd: