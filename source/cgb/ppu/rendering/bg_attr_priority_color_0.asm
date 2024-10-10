INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "vram.inc"
INCLUDE "dma.inc"
INCLUDE "cgb.inc"

; Check that OBJ overlap BG if BG color index is 0, regardless BG priority of BG attributes.
; (And implicitly check for a bare working VRAM1).

EntryPoint:
    DisablePPU

    ; Reset OAM
    ResetOAM

    ; Set OAM data
    Memcpy $fe00, OamData, OamDataEnd - OamData

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

    ; Write OBJ palettes
    ;               red+green             red+blue               green+blue             grey
    SetOBJP 0, %11111111, %00000011, %00011111, %01111100, %11100000, %01111111, %11100111, %00011100
    ;                 red                  green                   blue                black
    SetOBJP 1, %00011111, %00000000, %11100000, %00000011, %00000000, %01111100, %00000000, %00000000

    ; Write BG attributes to VRAM1
    ld a, 1
    ldh [rVBK], a

    ; BG palette = 0
    ; Priority = 1
    ld a, $80
    ld hl, $9841
    ld [hl], a

    ld hl, $9861
    ld [hl], a

    ld hl, $9803
    ld [hl], a

    ld hl, $9823
    ld [hl], a

    ; Enable PPU
    ld a, LCDCF_ON | LCDCF_BGON | LCDCF_OBJON
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


OamData:
db 16, 16, $81, $01
db 24, 16, $82, $01
db 32, 16, $81, $01
db 40, 16, $82, $01

db 16, 32, $81, $01
db 24, 32, $82, $01
db 32, 32, $81, $01
db 40, 32, $82, $01
OamDataEnd: