MACRO DumpRegistersCGB
    ; Disable interrupts
    di

    ; Save the registers
    push hl
    push de
    push bc
    push af

    DisablePPU
    InitPrint
    SetDefaultBGP

    ; Print each register
    PrintString "AF: "
    pop bc
    PutHex16
    NewLine

    PrintString "BC: "
    pop bc
    PutHex16
    NewLine

    PrintString "DE: "
    pop bc
    PutHex16
    NewLine

    PrintString "HL: "
    pop bc
    PutHex16
    NewLine

	ld a, LCDCF_ON | LCDCF_BGON
	ldh [rLCDC], a

    ; HALT forever.
    HaltForever
ENDM

; Args:
; \1: source
; \2: length
MACRO DumpMemoryCGB
    ; Disable interrupts
    di

    DisablePPU
    InitPrint
    SetDefaultBGP

    ld hl, \1 ; source address

    ld d, $00
    push de

.start\@
.loop\@
    ; Read one byte:
    ld a, [hli]

    ; Print it
    PutHex8

    ; Eventually print new line
    pop de
	inc d
    ld a, $07
    and d
    push de
	jp nz, .continue\@

	NewLine

.continue\@

	; Restart if BC != 0
	pop de
	ld b, \2
	ld a, d
	cp b
	push de
	jp nz, .loop\@

	ld a, LCDCF_ON | LCDCF_BGON
	ldh [rLCDC], a

    ; HALT forever.
    HaltForever
ENDM


; Args:
; \1: source
; \2: length
MACRO DumpMemoryAndWaitCGB
    DisablePPU
    InitPrint
    SetDefaultBGP

    ld hl, \1 ; source address

    ld d, $00
    push de

.start\@
.loop\@
    ; Read one byte:
    ld a, [hli]

    ; Print it
    PutHex8

    ; Eventually print new line
    pop de
	inc d
    ld a, $07
    and d
    push de
	jp nz, .continue\@

	NewLine

.continue\@

	; Restart if BC != 0
	pop de
	ld b, \2
	ld a, d
	cp b
	push de
	jp nz, .loop\@

	ld a, LCDCF_ON | LCDCF_BGON
	ldh [rLCDC], a

    ; HALT
    halt
ENDM