SECTION "Header", ROM0[$100]
    nop
	jp EntryPoint

	ds $150 - @, 0 ; Make room for the header

SECTION "Home", ROM0[$150]

MACRO HaltForever
    xor a
    ldh [rIE], a
    halt
ENDM

MACRO WaitVBlank
.loop\@
	ldh a, [rLY]
	cp 144
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

; Args:
; \1: number of nops
MACRO Nops
REPT \1
    nop
ENDR
ENDM

; Args:
; \1: number of scanline to skip
MACRO SkipLines
    Nops \1 * 114
ENDM
; Args:
; \1: destination address
; \2: source address
; \3: length
MACRO Memcpy
    ld hl, \1 ; destination address
    ld bc, \2 ; source address
    ld de, \3 ; length

.memcpyloop\@
    ; Transfer one byte from [BC++] to [HL++]
    ld a, [bc]
    inc bc
	ld [hli], a

	; Restart if DE != 0
	dec de
	ld a, d
	or e
	jp nz, .memcpyloop\@
ENDM

; Args:
; \1: tilemap start
; \2: tilemap end
MACRO PrintTilemap
    WaitVBlank

    ; Turn the LCD off
	xor a
	ldh [rLCDC], a

    ; Copy the tilemap to VRAM
	Memcpy $9000, \1, \2

    ; Turn on LCD
	ld a, LCDCF_ON | LCDCF_BGON
	ldh [rLCDC], a

    HaltForever
ENDM

TestSuccess:
    di
	PrintTilemap TestSuccessTilemap, TestSuccessTilemapEnd - TestSuccessTilemap

TestFail:
    di
    PrintTilemap TestFailTilemap, TestFailTilemapEnd - TestFailTilemap

TestSuccessTilemap:
	db $00, $00, $00, $00, $00, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00,
TestSuccessTilemapEnd:

TestFailTilemap:
	db $18, $18, $18, $18, $18, $18, $18, $18, $18, $18, $18, $18, $18, $18, $18, $18,
TestFailTilemapEnd: