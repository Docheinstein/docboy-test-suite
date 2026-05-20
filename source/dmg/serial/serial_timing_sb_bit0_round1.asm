INCLUDE "all.inc"
	
; Check the timing at which SB content changes.

EntryPoint:
    Wait 3

    Wait 0

    ; Start serial transfer
    ld a, $81
    ldh [rSC], a

    Wait 61

    ldh a, [rSB]
	cp $00
	
	jp nz, TestFail
	jp TestSuccess
