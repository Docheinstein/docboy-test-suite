INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "vram.inc"
INCLUDE "dma.inc"
INCLUDE "cgb.inc"

; LCDC[0] has a different meaning in CGB: it does not disable BG/WIN.

EntryPoint:
    DisablePPU

    ; Reset OAM
    ResetOAM

    ; Reset VRAM0
    ResetVRAM

    ; Set VRAM0 data
    Memcpy $8800, BackgroundVram0TileData, BackgroundVram0TileDataEnd - BackgroundVram0TileData
    Memcpy $9800, BackgroundVram0TileMapData, BackgroundVram0TileMapDataEnd - BackgroundVram0TileMapData

    ld a, 1
    ldh [rVBK], a

    ; Reset VRAM1
    ResetVRAM

    xor a
    ldh [rVBK], a

    ; Write BG palettes
    ;               red+green             red+blue               green+blue             grey
    SetBGP 0, %11111111, %00000011, %00011111, %01111100, %11100000, %01111111, %11100111, %00011100
    ;                 red                  green                   blue                black
    SetBGP 1, %00011111, %00000000, %11100000, %00000011, %00000000, %01111100, %00000000, %00000000

    ; Write BG attributes to VRAM1
    ld a, 1
    ldh [rVBK], a

    ; Bank = 0
    ; BG palette = 1
    ld a, $01
    ld hl, $9800
    ld [hl], a

    ld hl, $9820
    ld [hl], a

    ld hl, $9840
    ld [hl], a

    ld hl, $9860
    ld [hl], a

    xor a
    ldh [rVBK], a

    ; Enable PPU with LCDC[0] = 0
    ld a, LCDCF_ON | LCDCF_BGOFF
    ldh [rLCDC], a

    HaltForever

BackgroundVram0TileData:
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00
    db $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
BackgroundVram0TileDataEnd:

BackgroundVram0TileMapData:
    db $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80
    db $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80
    db $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81
    db $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81
    db $82, $82, $82, $82, $82, $82, $82, $82, $82, $82, $82, $82, $82, $82, $82, $82
    db $82, $82, $82, $82, $82, $82, $82, $82, $82, $82, $82, $82, $82, $82, $82, $82
    db $83, $83, $83, $83, $83, $83, $83, $83, $83, $83, $83, $83, $83, $83, $83, $83
    db $83, $83, $83, $83, $83, $83, $83, $83, $83, $83, $83, $83, $83, $83, $83, $83
BackgroundVram0TileMapDataEnd: