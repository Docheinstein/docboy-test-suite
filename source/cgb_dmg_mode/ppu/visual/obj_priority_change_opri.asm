INCLUDE "all.inc"

; Check if OPRI change has effect after boot.

EntryPoint:
    DisablePPU

    ; Set VRAM0 data
    Memcpy $8800, BackgroundVram0TileData, BackgroundVram0TileDataEnd - BackgroundVram0TileData

    ; Set OAM Data
    Memset $fe00, $00, 160
    Memcpy $fe00, OamData, OamDataEnd - OamData

    ; Write OBJ palette
    ld a, %11100100
    ldh [rOBP0], a
    ldh [rOBP1], a

    EnablePPU_WithSprites

    WaitVBlank

    ; Change OPRI
    ld a, $ff
    ldh [rOPRI], a

    HaltForever

BackgroundVram0TileData:
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00
    db $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
BackgroundVram0TileDataEnd:

OamData:
    ; OBJ 1
    db $10, 32, $81, $00

    ; OBJ 2
    db $10, 28, $82, $00

    ; OBJ 3
    db $10, 32, $83, $00
OamDataEnd: