INCLUDE "all.inc"
	
; Check the timing of serial transfer if DIV is reset before the transfer.

EntryPoint:
    Wait 3

    Wait 32

    ldh [rDIV], a

    Wait 30

    ; Start serial transfer
    ld a, $81
    ldh [rSC], a

    Wait 957 - 64 + 92

    Wait 1

    ldh a, [rSC]
	cp $7f
	
	jp nz, TestFail
	jp TestSuccess
