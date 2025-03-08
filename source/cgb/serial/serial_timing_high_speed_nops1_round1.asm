INCLUDE "all.inc"
	
; Check the timing of serial transfer with a certain alignment when running in high speed mode.

EntryPoint:
    ; Reset DIV
    xor a
    ldh [rDIV], a

    Nops 1

    ; Start serial transfer at high speed mode
    ld a, $83
    ldh [rSC], a

    Nops 28

    ldh a, [rSC]
	cp $ff
	
	jp nz, TestFail
	jp TestSuccess
