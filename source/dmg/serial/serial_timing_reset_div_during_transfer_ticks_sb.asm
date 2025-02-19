INCLUDE "all.inc"
	
; Check the timing of serial transfer if DIV is reset during a transfer.

EntryPoint:
    Nops 3

    Nops 64

    ; Start serial transfer
    ld a, $81
    ldh [rSC], a

    Nops 30

    ldh [rDIV], a

    ldh a, [rSB]
	cp $01
	
	jp nz, TestFail
	jp TestSuccess
