INCLUDE "all.inc"

; Check that OBJ goes on top of BG if LCDC bit 0 is disabled (and OAM bit 7 is set).

EntryPoint:
    DisablePPU

    ; Write BG palette
    ld a, %11100100
    ldh [rBGP], a

    ; Write OBJ palette
    ld a, %11100100
    ldh [rOBP0], a
    ldh [rOBP1], a

    ; Copy OAM data
    Memset $fe00, $00, 160
    Memcpy $fe00, OamData, OamDataEnd - OamData

    ; Reset VRAM
    Memset $8000, $00, $2000

    ; Set VRAM0 data
    Memcpy $8800, BackgroundVram0TileData, BackgroundVram0TileDataEnd - BackgroundVram0TileData
    Memcpy $9800, BackgroundVram0TileMapData, BackgroundVram0TileMapDataEnd - BackgroundVram0TileMapData

    ; Enable PPU with bit 0 set
	ld a, LCDCF_ON | LCDCF_BGON | LCDCF_OBJON
	ldh [rLCDC], a

    halt


BackgroundVram0TileData:
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00
    db $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff
BackgroundVram0TileDataEnd:

BackgroundVram0TileMapData:
    db $81, $81, $81, $81, $81, $81, $81, $81
BackgroundVram0TileMapDataEnd:

OamData:
    db $14, 68, $82, $80
OamDataEnd: