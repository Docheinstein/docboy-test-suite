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

    EnablePPU

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