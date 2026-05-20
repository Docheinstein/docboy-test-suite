INCLUDE "all.inc"
	
; Check the timing of serial transfer if DIV is reset during a transfer.

EntryPoint:
    Wait 3

    Wait 64

    ; Start serial transfer
    ld a, $81
    ldh [rSC], a

    Wait 30

    Wait 2

    ldh a, [rSB]
	cp $00
	
	jp nz, TestFail
	jp TestSuccess
