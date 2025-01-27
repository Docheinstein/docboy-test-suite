INCLUDE "docboy.inc"

; Check the duration of Pixel Transfer (Mode 3), with:
; SCX=5
; 1 sprite X=0

EntryPoint:
    WaitVBlank

    ; Set SCX=5
    ld a, $05
    ldh [rSCX], a

    ; Disable PPU
    DisablePPU

    ; Set OAM Data
    Memset $fe00, $00, 160
    Memcpy $fe00, OamData, OamDataEnd - OamData

    ; Enable PPU
    EnablePPU_WithSprites

    Nops 177

    ; We should still be in Pixel Transfer
    ldh a, [rSTAT]
    ld b, a

    ld a, $83
    cp b
    jp nz, TestFail

    jp TestSuccess

OamData:
    db $10, $00, $00, $00
    db $00, $00, $00, $00
OamDataEnd: