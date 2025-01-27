INCLUDE "docboy.inc"

; Check the duration of Pixel Transfer (Mode 3), with:
; SCX=0
; 2 sprite X=0

EntryPoint:
    WaitVBlank

    ; Set OAM Data
    Memset $fe00, $00, 160
    Memcpy $fe00, OamData, OamDataEnd - OamData

    ; Reset PPU phase
    DisablePPU

    ; Enable PPU with OBJ disable
    ld a, LCDCF_ON | LCDCF_BGON
	ldh [rLCDC], a

    Nops 174

    ; We should already be in HBlank
    ldh a, [rSTAT]
    ld b, a

    ld a, $80
    cp b
    jp nz, TestFail

    jp TestSuccess

OamData:
    db $10, $00, $00, $00
    db $10, $00, $00, $00
OamDataEnd: