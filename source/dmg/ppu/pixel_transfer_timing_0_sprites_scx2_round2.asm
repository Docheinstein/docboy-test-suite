INCLUDE "all.inc"

; Check the duration of Pixel Transfer (Mode 3), with:
; SCX=2
; 0 sprites

EntryPoint:
    WaitVBlank

    ; Set SCX=2
    ld a, $02
    ldh [rSCX], a

    ; Disable PPU
    DisablePPU

    ; Set OAM Data
    Memset $fe00, $00, 160
    Memcpy $fe00, OamData, OamDataEnd - OamData

    ; Enable PPU
    EnablePPU_WithSprites

    Nops 174

    ; We should already be in HBlank
    ldh a, [rSTAT]
    ld b, a

    ld a, $80
    cp b
    jp nz, TestFail

    jp TestSuccess

OamData:
    db $00, $00, $00, $00
    db $00, $00, $00, $00
OamDataEnd: