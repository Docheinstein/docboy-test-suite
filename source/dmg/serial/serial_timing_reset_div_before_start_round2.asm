INCLUDE "all.inc"
	
; Check the timing of serial transfer if DIV is reset before the transfer.

EntryPoint:
    Nops 3

    Nops 32

    ldh [rDIV], a

    Nops 30

    ; Start serial transfer
    ld a, $81
    ldh [rSC], a

    Nops 957 - 64 + 92

    Nops 1

    ldh a, [rSC]
	cp $7f
	
	jp nz, TestFail
	jp TestSuccess
