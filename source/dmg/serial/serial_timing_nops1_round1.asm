INCLUDE "all.inc"
	
; Check the timing of serial transfer with a certain alignment.

EntryPoint:
    Nops 3

    Nops 1

    ; Start serial transfer
    ld a, $81
    ldh [rSC], a

    Nops 957 - 1 + 64

    ldh a, [rSC]
	cp $ff
	
	jp nz, TestFail
	jp TestSuccess
