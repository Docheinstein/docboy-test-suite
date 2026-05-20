INCLUDE "all.inc"
	
; Check the timing at which SB content changes.

EntryPoint:
    Wait 3

    Wait 0

    ; Start serial transfer
    ld a, $81
    ldh [rSC], a

    Wait 6 * 128

    Wait 61

    ldh a, [rSB]
	cp $3f
	
	jp nz, TestFail
	jp TestSuccess
