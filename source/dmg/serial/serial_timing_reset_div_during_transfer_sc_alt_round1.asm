INCLUDE "all.inc"
	
; Check the timing of serial transfer if DIV is reset during a transfer.

EntryPoint:
    Nops 3

    Nops 64

    ; Start serial transfer
    ld a, $81
    ldh [rSC], a

    Nops 96

    ldh [rDIV], a

    Nops 957 - 128 - 1

    ldh a, [rSC]
	cp $ff
	
	jp nz, TestFail
	jp TestSuccess
