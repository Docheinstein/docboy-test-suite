INCLUDE "all.inc"
	
; Check the timing of serial transfer with a certain alignment.

EntryPoint:
    Wait 3

    Wait 65

    ; Start serial transfer
    ld a, $81
    ldh [rSC], a

    Wait 957 - 65 + 128

    Wait 1

    ldh a, [rSC]
	cp $7f
	
	jp nz, TestFail
	jp TestSuccess
