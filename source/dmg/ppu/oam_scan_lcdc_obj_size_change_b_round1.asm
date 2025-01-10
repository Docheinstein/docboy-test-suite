INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "vram.inc"

; Check timing of OAM scan by changing OBJ size during OAM scan
; with a sprite that is counted only OBJ size change takes effect.

EntryPoint:
    DisablePPU

    ; Reset VRAM
    ResetVRAM

    ; Reset OAM
    Memset $fe00, $00, 160

    ; Copy OAM data
    Memcpy $fe00, OamData, OamDataEnd - OamData

    EnablePPU

    ; Wait
    Nops 114 * 13

    Nops 111

	ld a, LCDCF_ON | LCDCF_BGON | LCDCF_OBJON | LCDCF_OBJ16
	ldh [rLCDC], a

	Nops 57

    ; Check STAT
	ldh a, [rSTAT]
    cp $83

    jp nz, TestFail
    jp TestSuccess

OamData:
db $00, $00, $00, $00
db $00, $00, $00, $00
db $00, $00, $00, $00
db $14, $10, $01, $00
OamDataEnd:
