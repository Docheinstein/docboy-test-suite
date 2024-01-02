INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "vram.inc"

; Render with window enabled, turn it off and reenable it again
; with WX moved ahead so that it retriggers the window.

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

    ; Window
    Memcpy $9010, WindowVramTileData, WindowVramTileDataEnd - WindowVramTileData
    Memcpy $9C00, WindowVramTileMapData, WindowVramTileMapDataEnd - WindowVramTileMapData

    ; Background
    Memcpy $8800, BackgroundVramTileData, BackgroundVramTileDataEnd - BackgroundVramTileData
    Memcpy $9800, BackgroundVramTileMapData, BackgroundVramTileMapDataEnd - BackgroundVramTileMapData

Loop:
    ; Adjust phase to avoid flickr.
    Nops 3

    ; Set WX=25
    ld a, 25
    ldh [rWX], a

    ; Enable window
    ld a, LCDCF_ON | LCDCF_BGON | LCDCF_WINON | LCDCF_WIN9C00
    ldh [rLCDC], a

    WaitScanline 12

    ; Wait so that a part of the window is render.
    Nops 16

    ; Disable window
    ld a, LCDCF_ON | LCDCF_BGON | LCDCF_WIN9C00
    ldh [rLCDC], a

    WaitVBlank

    jp Loop


WindowVramTileData:
    db $ff, $80, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00
    db $ff, $80, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00
    db $ff, $80, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00
    db $ff, $80, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00
    db $ff, $80, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00
    db $ff, $80, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00
    db $ff, $80, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00
    db $ff, $80, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00
    db $ff, $80, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00
    db $ff, $80, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00
    db $ff, $80, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00
    db $ff, $80, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00
    db $ff, $80, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00
    db $ff, $80, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00
    db $ff, $80, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00
    db $ff, $80, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00
    db $ff, $80, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00
WindowVramTileDataEnd:


WindowVramTileMapData:
    db $01, $02, $03, $04, $05, $06, $07, $08, $09, $0a, $0b, $0c, $0d, $0e, $0f, $10, $11, $12
WindowVramTileMapDataEnd:


BackgroundVramTileData:
    ; First row
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00


    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

    ; Second row
    db $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80,
    db $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81, $80, $81,
    db $80, $82, $80, $82, $80, $82, $80, $82, $80, $82, $80, $82, $80, $82, $80, $82,
    db $80, $83, $80, $83, $80, $83, $80, $83, $80, $83, $80, $83, $80, $83, $80, $83,
    db $80, $84, $80, $84, $80, $84, $80, $84, $80, $84, $80, $84, $80, $84, $80, $84,
    db $80, $85, $80, $85, $80, $85, $80, $85, $80, $85, $80, $85, $80, $85, $80, $85,
    db $80, $86, $80, $86, $80, $86, $80, $86, $80, $86, $80, $86, $80, $86, $80, $86,
    db $80, $87, $80, $87, $80, $87, $80, $87, $80, $87, $80, $87, $80, $87, $80, $87,
    db $80, $88, $80, $88, $80, $88, $80, $88, $80, $88, $80, $88, $80, $88, $80, $88,
    db $80, $89, $80, $89, $80, $89, $80, $89, $80, $89, $80, $89, $80, $89, $80, $89,
    db $80, $8a, $80, $8a, $80, $8a, $80, $8a, $80, $8a, $80, $8a, $80, $8a, $80, $8a,
    db $80, $8b, $80, $8b, $80, $8b, $80, $8b, $80, $8b, $80, $8b, $80, $8b, $80, $8b,
    db $80, $8c, $80, $8c, $80, $8c, $80, $8c, $80, $8c, $80, $8c, $80, $8c, $80, $8c,
    db $80, $8d, $80, $8d, $80, $8d, $80, $8d, $80, $8d, $80, $8d, $80, $8d, $80, $8d,
    db $80, $8e, $80, $8e, $80, $8e, $80, $8e, $80, $8e, $80, $8e, $80, $8e, $80, $8e,
    db $80, $8f, $80, $8f, $80, $8f, $80, $8f, $80, $8f, $80, $8f, $80, $8f, $80, $8f,

    db $c0, $c0, $c0, $c0, $c0, $c0, $c0, $c0, $c0, $c0, $c0, $c0, $c0, $c0, $c0, $c0,
    db $c0, $c1, $c0, $c1, $c0, $c1, $c0, $c1, $c0, $c1, $c0, $c1, $c0, $c1, $c0, $c1,
    db $c0, $c2, $c0, $c2, $c0, $c2, $c0, $c2, $c0, $c2, $c0, $c2, $c0, $c2, $c0, $c2,
    db $c0, $c3, $c0, $c3, $c0, $c3, $c0, $c3, $c0, $c3, $c0, $c3, $c0, $c3, $c0, $c3,
    db $c0, $c4, $c0, $c4, $c0, $c4, $c0, $c4, $c0, $c4, $c0, $c4, $c0, $c4, $c0, $c4,
    db $c0, $c5, $c0, $c5, $c0, $c5, $c0, $c5, $c0, $c5, $c0, $c5, $c0, $c5, $c0, $c5,
    db $c0, $c6, $c0, $c6, $c0, $c6, $c0, $c6, $c0, $c6, $c0, $c6, $c0, $c6, $c0, $c6,
    db $c0, $c7, $c0, $c7, $c0, $c7, $c0, $c7, $c0, $c7, $c0, $c7, $c0, $c7, $c0, $c7,
    db $c0, $c8, $c0, $c8, $c0, $c8, $c0, $c8, $c0, $c8, $c0, $c8, $c0, $c8, $c0, $c8,
    db $c0, $c9, $c0, $c9, $c0, $c9, $c0, $c9, $c0, $c9, $c0, $c9, $c0, $c9, $c0, $c9,
    db $c0, $ca, $c0, $ca, $c0, $ca, $c0, $ca, $c0, $ca, $c0, $ca, $c0, $ca, $c0, $ca,
    db $c0, $cb, $c0, $cb, $c0, $cb, $c0, $cb, $c0, $cb, $c0, $cb, $c0, $cb, $c0, $cb,
    db $c0, $cc, $c0, $cc, $c0, $cc, $c0, $cc, $c0, $cc, $c0, $cc, $c0, $cc, $c0, $cc,
    db $c0, $cd, $c0, $cd, $c0, $cd, $c0, $cd, $c0, $cd, $c0, $cd, $c0, $cd, $c0, $cd,
    db $c0, $ce, $c0, $ce, $c0, $ce, $c0, $ce, $c0, $ce, $c0, $ce, $c0, $ce, $c0, $ce,
    db $c0, $cf, $c0, $cf, $c0, $cf, $c0, $cf, $c0, $cf, $c0, $cf, $c0, $cf, $c0, $cf,
BackgroundVramTileDataEnd:


BackgroundVramTileMapData:
    db $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $8a, $8b, $8c, $8d, $8e, $8f
    db $90, $91, $92, $93, $94, $95, $96, $97, $98, $99, $9a, $9b, $9c, $9d, $9e, $9f
    db $a0, $a1, $a2, $a3, $a4, $a5, $a6, $a7, $a8, $a9, $aa, $ab, $ac, $ad, $ae, $af
    db $b0, $b1, $b2, $b3, $b4, $b5, $b6, $b7, $b8, $b9, $ba, $bb, $bc, $bd, $be, $bf
    db $c0, $c1, $c2, $c3, $c4, $c5, $c6, $c7, $c8, $c9, $ca, $cb, $cc, $cd, $ce, $cf
BackgroundVramTileMapDataEnd: