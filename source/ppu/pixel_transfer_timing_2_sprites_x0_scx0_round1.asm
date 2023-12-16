INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "dma.inc"

; Check the duration of Pixel Transfer (Mode 3), with:
; SCX=0
; 2 sprite X=0

EntryPoint:
    WaitVBlank

    ; Set OAM Data
    ResetOAM
    Memcpy $fe00, OamData, OamDataEnd - OamData

    ; Reset PPU phase
    ResetPPU

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
    db $10, $00, $00, $00
OamDataEnd: