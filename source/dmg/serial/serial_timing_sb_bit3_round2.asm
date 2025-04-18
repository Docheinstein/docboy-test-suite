INCLUDE "all.inc"
	
; Check the timing at which SB content changes.

EntryPoint:
    Nops 3

    Nops 0

    ; Start serial transfer
    ld a, $81
    ldh [rSC], a

    Nops 3 * 128

    Nops 61

    Nops 1

    ldh a, [rSB]
	cp $0f
	
	jp nz, TestFail
	jp TestSuccess
