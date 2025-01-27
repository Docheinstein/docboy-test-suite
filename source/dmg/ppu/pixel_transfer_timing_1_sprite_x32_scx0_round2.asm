INCLUDE "docboy.inc"

; Check the duration of Pixel Transfer (Mode 3), with:
; SCX=0
; 1 sprite X=32

EntryPoint:
    WaitVBlank

    ; Disable PPU
    DisablePPU

    ; Set OAM Data
    Memset $fe00, $00, 160
    Memcpy $fe00, OamData, OamDataEnd - OamData

    ; Enable PPU
    EnablePPU_WithSprites

    Nops 176

    ; We should already be in HBlank
    ldh a, [rSTAT]
    ld b, a

    ld a, $80
    cp b
    jp nz, TestFail

    jp TestSuccess

OamData:
    db $10, $20, $00, $00
    db $00, $00, $00, $00
OamDataEnd: