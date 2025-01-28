INCLUDE "all.inc"

; Disable window during pixel transfer at different fetcher
; phases (uses a sprite to change phase).

EntryPoint:
    ; Disable PPU
    DisablePPU

    ; Set BGP
    ld a, %11100100
    ldh [rBGP], a

    ; Set WY
    ld a, 4
    ldh [rWY], a

    ; Set WX
    ld a, 16
    ldh [rWX], a

    ; Reset VRAM and OAM
    ; Reset VRAM
    Memset $8000, $00, $2000
    Memset $fe00, $00, 160

    ; Set OAM data
    Memcpy $fe00, OamData, OamDataEnd - OamData

    ; Set Window VRAM data
    Memcpy $9010, WindowVramTileData, WindowVramTileDataEnd - WindowVramTileData
    Memcpy $9C00, WindowVramTileMapData, WindowVramTileMapDataEnd - WindowVramTileMapData

    ; Set BG VRAM data
    Memcpy $8800, BackgroundVramTileData, BackgroundVramTileDataEnd - BackgroundVramTileData
    Memcpy $9800, BackgroundVramTileMapData, BackgroundVramTileMapDataEnd - BackgroundVramTileMapData

    ; Enable PPU
    ld a, LCDCF_ON | LCDCF_BGON | LCDCF_OBJON | LCDCF_WINON | LCDCF_WIN9C00
    ldh [rLCDC], a

    ; -- Begin of frame --

    ; Go to line 8 of next frame
    LongWait 163 * 114

    ; Go to pixel transfer of line 8
    Nops 25

    ; Disable window
    ld a, LCDCF_ON | LCDCF_BGON | LCDCF_OBJON | LCDCF_WIN9C00
    ldh [rLCDC], a

    WaitVBlank

    ; Soft Breakpoint: good time to take a screenshot
    ld b, b

    halt
    nop

OamData:
    db 24, 0, 0, 0
OamDataEnd:

WindowVramTileData:
    ; Block tile
    db $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff,

    ; Stair tile
    db $80, $ff, $00, $3f, $00, $1f, $00, $0f, $00, $07, $00, $03, $00, $01, $00, $00,
WindowVramTileDataEnd:

WindowVramTileMapData:
    db $02, $02, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01,
    db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01,
    db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01,
    db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01,
    db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01,
    db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01,
    db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01,
    db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01,
WindowVramTileMapDataEnd:

BackgroundVramTileData:
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00,
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff,
    db $aa, $aa, $aa, $aa, $aa, $aa, $aa, $aa, $aa, $aa, $aa, $aa, $aa, $aa, $aa, $aa,
BackgroundVramTileDataEnd:

BackgroundVramTileMapData:
    db $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80,
    db $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80,
    db $81, $81, $82, $81, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80,
    db $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80,
    db $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80,
    db $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80,
    db $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80,
BackgroundVramTileMapDataEnd:
