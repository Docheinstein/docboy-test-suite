;! TITLE=PHYSICALLY
;! OLD_LICENSE=1

INCLUDE "all.inc"

; Check initial BG and OBJ palettes in DMG mode with a certain title's checksum.

EntryPoint:
    DisablePPU

    ; Write BG palette
    ld a, %11100100
    ldh [rBGP], a

    ; Write OBJ palette
    ld a, %11100100
    ldh [rOBP0], a
    ldh [rOBP1], a

    ; Reset OAM
    Memset $fe00, $00, 160

    ; Set OAM data
    Memcpy $fe00, OamData, OamDataEnd - OamData

    ; Reset VRAM0
    Memset $8000, $00, $2000

    ; Set VRAM0 data
    Memcpy $8800, BackgroundVram0TileData, BackgroundVram0TileDataEnd - BackgroundVram0TileData
    Memcpy $9800, BackgroundVram0TileMapData, BackgroundVram0TileMapDataEnd - BackgroundVram0TileMapData

    ; Enable PPU
    EnablePPU_WithSprites

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
db 64, 16, $80, $00
db 64, 24, $81, $00
db 64, 32, $82, $00
db 64, 40, $83, $00

db 64, 122, $80, $10
db 64, 128, $81, $10
db 64, 136, $82, $10
db 64, 144, $83, $10
OamDataEnd:
