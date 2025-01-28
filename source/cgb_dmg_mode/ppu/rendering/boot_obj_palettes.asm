;! TITLE=DOCTEST

INCLUDE "all.inc"

; Check initial OBJ palette.

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
    ; Reset VRAM
    Memset $8000, $00, $2000

    ; Set VRAM0 data
    Memcpy $8800, BackgroundVram0TileData, BackgroundVram0TileDataEnd - BackgroundVram0TileData

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
db 24, 16, $81, $00
db 24, 24, $82, $00
db 24, 32, $83, $00

db 40, 16, $81, $10
db 40, 24, $82, $10
db 40, 32, $83, $10
OamDataEnd: