INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Render with window enabled, WX=0 and SCX=5.

EntryPoint:
    ; Disable PPU
    DisablePPU

    ; Place a tile to VRAM Tile Data[1]
    Memset $9010, $ff, $10

    ; Reset VRAM Tile Map
    Memset $9C00, $00, $0400

    ; Write Index 1 to VRAM Tile Map[0] and [1]
    Memset $9C00, $01, $02

    ; Write WX=0
    ld a, $00
    ldh [rWX], a

    ; Write SCX=5
    ld a, $05
    ldh [rSCX], a

    ; Enable PPU with window on
    ld a, LCDCF_ON | LCDCF_BGON | LCDCF_WINON | LCDCF_WIN9C00
    ldh [rLCDC], a

    WaitVBlank

    halt
    nop
