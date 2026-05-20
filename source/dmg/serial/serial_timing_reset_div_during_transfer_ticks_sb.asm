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

    ldh a, [rSB]
	cp $01
	
	jp nz, TestFail
	jp TestSuccess
