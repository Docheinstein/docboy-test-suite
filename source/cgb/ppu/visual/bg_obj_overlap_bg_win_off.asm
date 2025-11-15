INCLUDE "all.inc"

; Check that OBJ goes on top of BG if LCDC bit 0 is disabled (and OAM bit 7 is set).

EntryPoint:
    DisablePPU

    ; Copy OAM data
    Memset $fe00, $00, 160
    Memcpy $fe00, OamData, OamDataEnd - OamData

    ld a, $01
    ldh [rVBK], a

    ; Reset VRAM
    Memset $8000, $00, $2000

    xor a
    ldh [rVBK], a

    ; Reset VRAM
    Memset $8000, $00, $2000

    ; Write BG palettes
    ;               red+green             red+blue               green+blue             grey
    SetBGP 0, %11111111, %00000011, %00011111, %01111100, %11100000, %01111111, %11100111, %00011100

    ; Write OBJ palettes
    ;                 red                  green                   blue                black
    SetOBJP 0, %00011111, %00000000, %11100000, %00000011, %00000000, %01111100, %00000000, %00000000

    ; Set VRAM0 data
    Memcpy $8800, BackgroundVram0TileData, BackgroundVram0TileDataEnd - BackgroundVram0TileData
    Memcpy $9800, BackgroundVram0TileMapData, BackgroundVram0TileMapDataEnd - BackgroundVram0TileMapData

    ; Enable PPU with bit 0 clear
	ld a, LCDCF_ON | LCDCF_BGOFF | LCDCF_OBJON
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