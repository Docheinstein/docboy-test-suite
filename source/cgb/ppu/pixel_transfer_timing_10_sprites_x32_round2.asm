INCLUDE "all.inc"

; Check the duration of Pixel Transfer (Mode 3), with:

EntryPoint:
    DisablePPU

    ; Set OAM Data
    Memset $fe00, $00, 160
    Memcpy $fe00, OamData, OamDataEnd - OamData

    EnablePPU_WithSprites

    Nops 189

    ; We should already be in HBlank
    ldh a, [rSTAT]
    cp $80
    jp nz, TestFail

    jp TestSuccess

OamData:
    db $10, 32, $00, $00
    db $10, 32, $00, $00
    db $10, 32, $00, $00
    db $10, 32, $00, $00
    db $10, 32, $00, $00
    db $10, 32, $00, $00
    db $10, 32, $00, $00
    db $10, 32, $00, $00
    db $10, 32, $00, $00
OamDataEnd: