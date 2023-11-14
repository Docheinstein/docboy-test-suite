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
.loop
	ldh a, [rLY]
	cp 144
	jr nz,.loop
ENDM

MACRO WaitScanline
.loop
	ldh a, [rLY]
	cp \1
	jr nz,.loop
ENDM

MACRO Nops
REPT \1
    nop
ENDR
ENDM

; Args:
; BC: tilemap start
; DE: tilemap end
PrintTilemap:
    WaitVBlank

    ; Turn the LCD off
	ld a, 0
	ldh [rLCDC], a

    ; Setup the copy
	ld hl, $9000

.copyloop
    ; Transfer one byte
    ld a, [bc]
	ld [hli], a
	inc bc

	; Restart if bc != de
	ld a, b
	cp d
    jp nz, .copyloop
	ld a, c
	cp e
    jp nz, .copyloop

    ; Turn on LCD
	ld a, LCDCF_ON | LCDCF_BGON
	ldh [rLCDC], a

    HaltForever


TestSuccess:
    ; Disable interrupts
    di
    nop

	ld bc, TestSuccessTilemap
	ld de, TestSuccessTilemapEnd
	jp PrintTilemap

TestFail:
    ; Disable interrupts
    di
    nop

	ld bc, TestFailTilemap
	ld de, TestFailTilemapEnd
    jp PrintTilemap

TestSuccessTilemap:
	db $00, $00, $00, $00, $00, $00, $00, $ff, $ff, $ff, $ff, $00, $00, $00, $00, $00,
;	db $00, $00, $01, $01, $02, $02, $04, $04, $88, $88, $50, $50, $20, $20, $00, $00
TestSuccessTilemapEnd:

TestFailTilemap:
	db $18, $18, $18, $18, $18, $18, $18, $18, $18, $18, $18, $18, $18, $18, $18, $18,
TestFailTilemapEnd: