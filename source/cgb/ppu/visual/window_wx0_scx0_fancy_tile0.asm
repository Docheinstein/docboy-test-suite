INCLUDE "all.inc"

; Render with window enabled, WX=0 and SCX=1.

EntryPoint:
    ; Disable PPU
    DisablePPU

    ; Write BG palettes
    ;               red+green             red+blue               green+blue             grey
    SetBGP 0, %11111111, %00000011, %00011111, %01111100, %11100000, %01111111, %11100111, %00011100
    ;                 red                  green                   blue                black
    SetBGP 1, %00011111, %00000000, %11100000, %00000011, %00000000, %01111100, %00000000, %00000000

    Memcpy $9000, WindowVramTileData, WindowVramTileDataEnd - WindowVramTileData
    Memset $9010, $ff, $10
    Memset $9020, $00, $10

    Memset $9C00, $02, $0400
    Memset $9C00, $01, $02

    ; Write WX=0
    ld a, $00
    ldh [rWX], a

    ; Write SCX=0
    ld a, $00
    ldh [rSCX], a

    ; Enable PPU with window on
    ld a, LCDCF_ON | LCDCF_BGON | LCDCF_WINON | LCDCF_WIN9C00 | LCDCF_BG9800
    ldh [rLCDC], a

    WaitVBlank

    halt
    nop

WindowVramTileData:
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00
WindowVramTileDataEnd:
