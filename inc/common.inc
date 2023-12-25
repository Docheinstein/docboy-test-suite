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

MACRO EnablePPU
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



; Args:
; \1: destination address
; \2: value
; \3: length
MACRO Memset
    ld hl, \1 ; destination address
    ld b,  \2 ; value
    ld de, \3 ; length

.loop\@
    ; Set [HL++]=value
    ld a, b
	ld [hli], a

	; Restart if DE != 0
	dec de
	ld a, d
	or e
	jp nz, .loop\@
ENDM


; Args:
; \1: destination address
; \2: source address
; \3: length
MACRO Memcpy
    ld hl, \1 ; destination address
    ld bc, \2 ; source address
    ld de, \3 ; length

.loop\@
    ; Transfer one byte: [HL++]=[BC++]
    ld a, [bc]
    inc bc
	ld [hli], a

	; Restart if DE != 0
	dec de
	ld a, d
	or e
	jp nz, .loop\@
ENDM


; Args:
; \1: first address
; \2: second address
; \3: length
; OUT: Z=0 if success
MACRO Memcmp
    ld hl, \1 ; first address
    ld bc, \2 ; second address
    ld de, \3 ; length

.loop\@
    ; Compare one byte
    ld a, [bc]
	cp [hl]
	jp nz, .fail\@

    inc bc
    inc hl

	; Restart if DE != 0
	dec de
	ld a, d
	or e
	jp nz, .loop\@

	xor a
	jp .end\@

.fail\@
    xor a
    inc a
.end\@
ENDM


; Args:
; \1: address
; \2: expected value
; OUT: Z=0 if success
MACRO Memtest
    ld hl, \1 ; address
    ld b,  \2 ; expected value

    ; Compare byte
    ld a, [hl]
	cp b
	jp nz, .fail\@

	xor a
	jp .end\@

.fail\@
    xor a
    inc a
.end\@
ENDM


; Args:
; \1: tilemap start
; \2: tilemap end
MACRO PrintTilemap
    WaitVBlank

    ; Turn the LCD off
    DisablePPU

    ; Copy the tilemap to VRAM
	Memcpy $9000, \1, \2

    ; Turn on LCD on
    EnablePPU

    HaltForever
ENDM

MACRO TestEndCleanup
    ; Disable interrupts
    di

    ; Turn off PPU
    DisablePPU

    ; Reset VRAM
    Memset $8000, $00, $2000

    ; Reset BG palette
    ld a, $fc
    ldh [rBGP], a

    ; Turn on PPU again
    EnablePPU
ENDM

TestSuccess:
    TestEndCleanup
	PrintTilemap TestSuccessTilemap, TestSuccessTilemapEnd - TestSuccessTilemap

TestFail:
    TestEndCleanup
    PrintTilemap TestFailTilemap, TestFailTilemapEnd - TestFailTilemap

TestSuccessTilemap:
	db $00, $00, $00, $00, $00, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00,
TestSuccessTilemapEnd:

TestFailTilemap:
	db $18, $18, $18, $18, $18, $18, $18, $18, $18, $18, $18, $18, $18, $18, $18, $18,
TestFailTilemapEnd: