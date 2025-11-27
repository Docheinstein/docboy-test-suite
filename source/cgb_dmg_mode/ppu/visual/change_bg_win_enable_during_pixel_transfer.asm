INCLUDE "all.inc"

; Change LCDC BG window enable flag during pixel transfer.

EntryPoint:
    DisablePPU

    ; Write BGP
    ld a, %00001000
    ldh [rBGP], a

    ; Reset VRAM
    Memset $8000, $00, $2000

    ; Set VRAM data
    Memcpy $8800, BackgroundVramTileData, BackgroundVramTileDataEnd - BackgroundVramTileData
    Memcpy $9800, BackgroundVramTileMapData, BackgroundVramTileMapDataEnd - BackgroundVramTileMapData

	ld a, LCDCF_ON | LCDCF_BGON
	ldh [rLCDC], a

MACRO SetAndResetBgEn
    Wait 70 - \1

    ld a, LCDCF_ON | LCDCF_BGON
    ldh [rLCDC], a

    Wait 35 + \1

    ld a, LCDCF_ON | LCDCF_BGOFF
    ldh [rLCDC], a
ENDM

Loop:
    Wait 22

    SetAndResetBgEn 0
    SetAndResetBgEn 1
    SetAndResetBgEn 2
    SetAndResetBgEn 3
    SetAndResetBgEn 4
    SetAndResetBgEn 5
    SetAndResetBgEn 6
    SetAndResetBgEn 7
    SetAndResetBgEn 8

    WaitVBlank

    ld a, LCDCF_ON | LCDCF_BGON
    ldh [rLCDC], a

    Wait 114 * 9 + 97
    jp Loop

    halt
    nop

BackgroundVramTileData:
    ; First row
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00
    db $f0, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00
BackgroundVramTileDataEnd:

BackgroundVramTileMapData:
    db $81, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80
    db $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80

    db $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80
    db $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80
BackgroundVramTileMapDataEnd: