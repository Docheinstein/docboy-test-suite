MACRO DumpRegisters
    ; Disable interrupts
    di

    ; Save the registers
    push hl
    push de
    push bc
    push af

    DisablePPU
    InitPrint

    IF CGB
        SetDefaultBGP
    ENDC

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
MACRO DumpMemory
    ; Disable interrupts
    di

    DisablePPU
    InitPrint

    IF CGB
        SetDefaultBGP
    ENDC

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

	EnablePPU

    ; HALT forever.
    HaltForever
ENDM


; Prints $80 bytes from address in stack
MACRO DumpMemoryInteractivePage
    DisablePPU

    InitPrint

    pop bc

    ld hl, $ff91
    ld [hl], b
    inc hl
    ld [hl], c

    ld h, b
    ld l, c

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
	ld b, $80
	ld a, d
	cp b
	push de
	jp nz, .loop\@

    NewLine

REPT 16
    PrintChar $20 ; ' '
ENDR

    ld hl, $ff91
    ld b, [hl]
    inc hl
    ld c, [hl]

    PutHex16

	ld a, LCDCF_ON | LCDCF_BGON
	ldh [rLCDC], a
ENDM

; Args:
; \1: source
MACRO DumpMemoryInteractive
    xor a
    ld hl, $ff90
    ld [hl], a

    DisablePPU

.printsetup\@
    ld hl, $ff90
    ld a, [hl]

    ld hl, \1
    ld bc, $80

    ld d, a

    jp z, .print\@
.printsetuploop\@
    add hl, bc
    dec d
    jp nz, .printsetuploop\@

.print\@
    push hl

    DumpMemoryInteractivePage

.wait\@
    ld a, [rP1]

    and $01
    jp z, .right\@

    ld a, [rP1]
    and $02
    jp z, .left\@

    jp .wait\@

.left\@
    ld a, [rP1]
    and $02
    jp z, .left\@

    ld hl, $ff90
    ld a, [hl]
    dec a
    ld [hl], a
    jp .printsetup\@


.right\@
    ld a, [rP1]
    and $01
    jp z, .right\@

    ld hl, $ff90
    ld a, [hl]
    inc a
    ld [hl], a
    jp .printsetup\@
ENDM
