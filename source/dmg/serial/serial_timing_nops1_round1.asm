INCLUDE "all.inc"
	
; Check the timing of serial transfer with a certain alignment.

EntryPoint:
    Wait 3

    Wait 1

    ; Start serial transfer
    ld a, $81
    ldh [rSC], a

    Wait 957 - 1 + 64

    ldh a, [rSC]
	cp $ff
	
	jp nz, TestFail
	jp TestSuccess
