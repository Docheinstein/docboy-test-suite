INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "vram.inc"

; Render with window enabled, turn it off and reenable it again
; with WX moved ahead so that it possibly retriggers the window.

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

    ; Set WX=15
    ld a, 15
    ldh [rWX], a

    ; Enable PPU with window on
    ld a, LCDCF_ON | LCDCF_BGON | LCDCF_WINON | LCDCF_WIN9C00
    ldh [rLCDC], a

    WaitScanline 12

    ; Wait so that a part of the window is render.
    Nops 21

    ; Disable window
    ld a, LCDCF_ON | LCDCF_BGON | LCDCF_WIN9C00
    ldh [rLCDC], a

    ; Let some BG fetch run.
    Nops 6

    ; Set WX=131 (misaligned w.r.t. the tilemap)
    ld a, 131
    ldh [rWX], a

    ; Adjust phase to avoid flickr.
    Nops 3

    ; Enable PPU with window on
    ld a, LCDCF_ON | LCDCF_BGON | LCDCF_WINON | LCDCF_WIN9C00
    ldh [rLCDC], a

    Nops 3

    ; Disable window
    ld a, LCDCF_ON | LCDCF_BGON | LCDCF_WIN9C00
    ldh [rLCDC], a

    WaitVBlank

    jp Loop

WindowVramTileData:
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
WindowVramTileDataEnd:


WindowVramTileMapData:
    db $01, $02, $03, $04, $05, $06, $07, $08, $09, $0a, $0b, $0c, $0d, $0e, $0f, $10, $11, $12
WindowVramTileMapDataEnd:

BackgroundVramTileData:
    db $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa
    db $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa
    db $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa
    db $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa
    db $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa
    db $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa
    db $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa
    db $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa
    db $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa
    db $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa
    db $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa
    db $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa
    db $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa
    db $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa
    db $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa
    db $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa
    db $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa
    db $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa
    db $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa
    db $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa
    db $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa
    db $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa
    db $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa
    db $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa
    db $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa
    db $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa
    db $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa
    db $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa
    db $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa
    db $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa
    db $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa
    db $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa
    db $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa
    db $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa
    db $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa
    db $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa
    db $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa
    db $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa
    db $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa
    db $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa
    db $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa
    db $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa
    db $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa
    db $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa
    db $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa
    db $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa
    db $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa

    ; First tile overlapping window
    db $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa
    db $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa, $cc, $aa
    db $1f, $e4, $1f, $e4, $1f, $e4, $1f, $e4, $1f, $e4, $1f, $e4, $1f, $e4, $1f, $e4
    db $3f, $c6, $3f, $c6, $3f, $c6, $3f, $c6, $3f, $c6, $3f, $c6, $3f, $c6, $3f, $c6
    db $7f, $9c, $7f, $9c, $7f, $9c, $7f, $9c, $7f, $9c, $7f, $9c, $7f, $9c, $7f, $9c
    db $1f, $ec, $1f, $ec, $1f, $ec, $1f, $ec, $1f, $ec, $1f, $ec, $1f, $ec, $1f, $ec
BackgroundVramTileDataEnd:


BackgroundVramTileMapData:
    db $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $8a, $8b, $8c, $8d, $8e, $8f
    db $90, $91, $92, $93, $94, $95, $96, $97, $98, $99, $9a, $9b, $9c, $9d, $9e, $9f
    db $a0, $a1, $a2, $a3, $a4, $a5, $a6, $a7, $a8, $a9, $aa, $ab, $ac, $ad, $ae, $af
    db $b0, $b1, $b2, $b3, $b4, $b5, $b6, $b7, $b8, $b9, $ba, $bb, $bc, $bd, $be, $bf
    db $c0, $c1, $c2, $c3, $c4, $c5, $c6, $c7, $c8, $c9, $ca, $cb, $cc, $cd, $ce, $cf
BackgroundVramTileMapDataEnd: