INCLUDE "all.inc"

; Check that OAM attribute bank is ignored in DMG mode.

EntryPoint:
    DisablePPU

    ; Reset OAM
    Memset $fe00, $00, 160

    ; Copy OAM data
    Memcpy $fe00, OamData, OamDataEnd - OamData

    ; Write BG palette
    ld a, %11100100
    ldh [rBGP], a

    ; Write OBJ palette
    ld a, %11100100
    ldh [rOBP0], a
    ldh [rOBP1], a

    EnablePPU_WithSprites

    halt

OamData:
    db $10, 32, $19, $08
OamDataEnd: