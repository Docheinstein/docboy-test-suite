INCLUDE "all.inc"

; Render with window enabled, wait for WX to trigger the window,
; than move WX ahead so that the window will encounter it again.
; The internal window line counter should be increased and it
; should render one line less of the window tile.

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
    ; Reset VRAM
    Memset $8000, $00, $2000

    ; Set Window VRAM data
    Memcpy $9010, WindowVramTileData, WindowVramTileDataEnd - WindowVramTileData
    Memcpy $9C00, WindowVramTileMapData, WindowVramTileMapDataEnd - WindowVramTileMapData

    ; Enable PPU with window on
    ld a, LCDCF_ON | LCDCF_BGON | LCDCF_WINON | LCDCF_WIN9C00
    ldh [rLCDC], a

Loop:
    ; Set WX
    ld a, 15
    ldh [rWX], a

    WaitScanline 12

    ; 8 nops are enough to read the first WX, so it encounters
    ; the second WX as first window trigger and the window
    ; will be rendered as usual.
    Nops 8

    ; Set WX
    ld a, 63
    ldh [rWX], a

    WaitVBlank

    jp Loop

WindowVramTileData:
    db $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
WindowVramTileDataEnd:

WindowVramTileMapData:
    db $01, $02, $03, $04
WindowVramTileMapDataEnd: