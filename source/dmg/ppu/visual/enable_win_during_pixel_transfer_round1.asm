INCLUDE "all.inc"

; Enable window during pixel transfer just about when WX condition is going to be satisfied.

EntryPoint:
    ; Disable PPU
    DisablePPU

    ; Enable VBlank interrupt
    xor a
    ldh [rIF], a

    ld a, $01
    ldh [rIE], a

    ; Set BGP
    ld a, %11100100
    ldh [rBGP], a

    ; Set WX
    ld a, 22
    ldh [rWX], a

    ; Set SCX
    ld a, 1
    ldh [rSCX], a

    ; Reset VRAM and OAM
    ; Reset VRAM
    Memset $8000, $00, $2000

    ; Set VRAM data
    Memcpy $9000, VramTileData, VramTileDataEnd - VramTileData
    Memcpy $9800, WindowVramTileMapData9800, WindowVramTileMapData9800End - WindowVramTileMapData9800
    Memcpy $9C00, WindowVramTileMapData9C00, WindowVramTileMapData9C00End - WindowVramTileMapData9C00

    ld b, LCDCF_ON | LCDCF_BGON | LCDCF_WINOFF | LCDCF_WIN9800 | LCDCF_BG9C00
    ld c, LCDCF_ON | LCDCF_BGON | LCDCF_WINON | LCDCF_WIN9800 | LCDCF_BG9C00
    ld hl, $ff40

    ei

Loop:
    ; Enable window
    ld [hl], c

    ; Set WY
    ld a, 2
    ldh [rWY], a

    ; -- window activation from frame will be triggered --

    ; Got to line 8
    Wait 114 * 8

    ; Disable window before pixel transfer
    ld [hl], b

    Nops 24

    ; Enable window
    ld [hl], c

    halt

    Wait 114 * 10 - 20

    jp Loop

    jp TestFail

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

SECTION "VBlank handler", ROM0[$40]
    reti
