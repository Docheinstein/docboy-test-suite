INCLUDE "all.inc"
	
; Check the timing of serial transfer with a certain alignment.

EntryPoint:
    ; Reset DIV
    xor a
    ldh [rDIV], a

    ; Start serial transfer
    ld a, $81
    ldh [rSC], a

    Nops 1015

    ldh a, [rSC]
	cp $fd
	
	jp nz, TestFail
	jp TestSuccess
