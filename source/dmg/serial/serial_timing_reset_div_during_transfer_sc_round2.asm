INCLUDE "all.inc"
	
; Check the timing of serial transfer if DIV is reset during a transfer.

EntryPoint:
    Wait 3

    Wait 64

    ; Start serial transfer
    ld a, $81
    ldh [rSC], a

    Wait 30

    ldh [rDIV], a

    Wait 957 - 64 - 1

    Wait 1

    ldh a, [rSC]
	cp $7f
	
	jp nz, TestFail
	jp TestSuccess
