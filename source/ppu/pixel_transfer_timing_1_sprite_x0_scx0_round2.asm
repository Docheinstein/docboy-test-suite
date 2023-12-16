INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "dma.inc"

; Check the duration of Pixel Transfer (Mode 3), with:
; SCX=0
; 1 sprite X=0

EntryPoint:
    WaitVBlank

    ; Set OAM Data
    ResetOAM
    Memcpy $fe00, OamData, OamDataEnd - OamData

    ; Reset PPU phase
    ResetPPU

    Nops 176

    ; We should already be in HBlank
    ldh a, [rSTAT]
    ld b, a

    ld a, $80
    cp b
    jp nz, TestFail

    jp TestSuccess

OamData:
    db $10, $00, $00, $00
    db $00, $00, $00, $00
OamDataEnd: