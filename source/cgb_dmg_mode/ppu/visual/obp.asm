Title "REDUCTIONS"
OldLicenseeCode $01

INCLUDE "all.inc"

; OBP must be honored in DMG mode.

EntryPoint:
    DisablePPU

    ; Write OBJ palette
    ld a, %00100111
    ldh [rOBP0], a

    ld a, %00111001
    ldh [rOBP1], a

    ; Reset OAM
    Memset $fe00, $00, 160

    ; Set OAM data
    Memcpy $fe00, OamData, OamDataEnd - OamData

    ; Reset VRAM0
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
db 64, 16, $80, $00
db 64, 24, $81, $00
db 64, 32, $82, $00
db 64, 40, $83, $00

db 64, 122, $80, $10
db 64, 128, $81, $10
db 64, 136, $82, $10
db 64, 144, $83, $10
OamDataEnd:
