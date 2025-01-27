INCLUDE "docboy.inc"

; Check that OBJ palette of OBJ attributes is honored.

EntryPoint:
    DisablePPU

    ; Reset OAM
    Memset $fe00, $00, 160

    ; Set OAM data
    Memcpy $fe00, OamData, OamDataEnd - OamData

    ; Reset VRAM0
    ; Reset VRAM
    Memset $8000, $00, $2000

    ; Set VRAM0 data
    Memcpy $8800, BackgroundVram0TileData, BackgroundVram0TileDataEnd - BackgroundVram0TileData

    ; Write BG palettes
    ;               red+green             red+blue               green+blue             grey
    SetOBJP 0, %11111111, %00000011, %00011111, %01111100, %11100000, %01111111, %11100111, %00011100
    ;                 red                  green                   blue                black
    SetOBJP 1, %00011111, %00000000, %11100000, %00000011, %00000000, %01111100, %00000000, %00000000

    ; Enable PPU
    EnablePPU_WithSprites

    HaltForever

BackgroundVram0TileData:
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00
    db $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
BackgroundVram0TileDataEnd:

OamData:
db 24, 16, $80, $00
db 24, 24, $81, $00
db 24, 32, $82, $00
; Unpredicatble since last byte of OBJP is random.
; db 24, 40, $83, $00

db 40, 16, $80, $01
db 40, 24, $81, $01
db 40, 32, $82, $01
; Unpredicatble since last byte of OBJP is random.
; db 40, 40, $83, $01
OamDataEnd: