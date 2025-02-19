INCLUDE "all.inc"
	
; Check the timing at which SB content changes.

EntryPoint:
    Nops 3

    Nops 0

    ; Start serial transfer
    ld a, $81
    ldh [rSC], a

    Nops 7 * 128

    Nops 61

    ldh a, [rSB]
	cp $7f
	
	jp nz, TestFail
	jp TestSuccess
