INCLUDE "all.inc"
	
; Check the timing of serial transfer with a certain alignment.

EntryPoint:
    Nops 3

    Nops 65

    ; Start serial transfer
    ld a, $81
    ldh [rSC], a

    Nops 957 - 65 + 128

    Nops 1

    ldh a, [rSC]
	cp $7f
	
	jp nz, TestFail
	jp TestSuccess
