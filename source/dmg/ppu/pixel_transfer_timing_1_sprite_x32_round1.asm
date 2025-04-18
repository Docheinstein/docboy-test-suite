INCLUDE "all.inc"

; Check the duration of Pixel Transfer (Mode 3), with:

EntryPoint:
    DisablePPU

    ; Set OAM Data
    Memset $fe00, $00, 160
    Memcpy $fe00, OamData, OamDataEnd - OamData

    EnablePPU_WithSprites

    Nops 175

    ; We should still be in Pixel Transfer
    ldh a, [rSTAT]
    cp $83
    jp nz, TestFail

    jp TestSuccess

OamData:
    db $10, 32, $00, $00
OamDataEnd: