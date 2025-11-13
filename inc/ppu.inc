IF !DEF(PPU_INC)
DEF PPU_INC EQU 1

INCLUDE "hardware.inc"

MACRO EnablePPU
	ld a, LCDCF_ON | LCDCF_BGON
	ldh [rLCDC], a
ENDM

MACRO EnablePPU_WithSprites
	ld a, LCDCF_ON | LCDCF_BGON | LCDCF_OBJON
	ldh [rLCDC], a
ENDM

MACRO DisablePPU
	xor a
	ldh [rLCDC], a
ENDM

MACRO ResetPPU
	DisablePPU
	EnablePPU
ENDM


; Args
; \1 mode
MACRO WaitMode
    ld b, $3
    ld c, \1
.loop\@
	ldh a, [rSTAT]
	and b
	cp c
	jr nz,.loop\@
ENDM


; Args:
; \1: scanline number
MACRO WaitScanline
.loop\@
	ldh a, [rLY]
	cp \1
	jr nz,.loop\@
ENDM


MACRO WaitVBlank
.loop\@
	ldh a, [rLY]
	cp 144
	jr nz,.loop\@
ENDM

ENDC