INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "vram.inc"
INCLUDE "dma.inc"
INCLUDE "cgb.inc"

; Check that BG attributes for Window are read from tilemap at VRAM1:9C00 if LCDC[6] is set.
; (And implicitly check for a bare working VRAM1).

EntryPoint:
    DisablePPU

    ; Set WY
    ld a, 8
    ldh [rWY], a

    ; Set WX=16
    ld a, 16
    ldh [rWX], a

    ; Reset OAM
    ResetOAM

    ; Reset VRAM0
    ResetVRAM

    ; Set VRAM0 data
    Memcpy $8800, BackgroundVram0TileData, BackgroundVram0TileDataEnd - BackgroundVram0TileData
    Memcpy $9800, BackgroundVram0TileMapData9800, BackgroundVram0TileMapData9800End - BackgroundVram0TileMapData9800
    Memcpy $9C00, BackgroundVram0TileMapData9C00, BackgroundVram0TileMapData9C00End - BackgroundVram0TileMapData9C00

    ld a, 1
    ldh [rVBK], a

    ; Reset VRAM1
    ResetVRAM

    xor a
    ldh [rVBK], a

    ; Write BG palettes
    ;               red+green             red+blue               green+blue             grey
    SetBGP 0, %11111111, %00000011, %00011111, %01111100, %11100000, %01111111, %11101111, %00111101
    ;                 red                  green                   blue                black
    SetBGP 1, %00011111, %00000000, %11100000, %00000011, %00000000, %01111100, %00000000, %00000000
    ;              dark red               dark green             dark blue              white
    SetBGP 2, %00001111, %00000000, %11100000, %00000001, %00000000, %00111100, %11111111, %11111111

    ; Write BG attributes to VRAM1
    ld a, 1
    ldh [rVBK], a

    ; Attributes for Tilemap 9800

    ; Bank = 0
    ; BG palette = 1
    ld a, $01
    ld hl, $9800
    ld [hl], a

    ; Bank = 0
    ; BG palette = 1
    ld a, $01
    ld hl, $9801
    ld [hl], a

    ; Attributes for Tilemap 9C00

    ; Bank = 0
    ; BG palette = 2
    ld a, $02
    ld hl, $9C00
    ld [hl], a

    ; Bank = 0
    ; BG palette = 2
    ld a, $02
    ld hl, $9C01
    ld [hl], a

    xor a
    ldh [rVBK], a

    ; Enable PPU
    ld a, LCDCF_ON | LCDCF_BGON | LCDCF_WINON | LCDCF_WIN9C00
    ldh [rLCDC], a

    HaltForever

BackgroundVram0TileData:
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00
    db $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
BackgroundVram0TileDataEnd:

BackgroundVram0TileMapData9800:
    db $80, $81, $80, $81
BackgroundVram0TileMapData9800End:

BackgroundVram0TileMapData9C00:
    db $82, $83, $82, $83
BackgroundVram0TileMapData9C00End: