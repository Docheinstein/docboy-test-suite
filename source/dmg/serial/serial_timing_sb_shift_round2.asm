INCLUDE "all.inc"
	
; Check the timing at which SB content changes.

EntryPoint:
    ld a, %10100001
    ldh [rSB], a

    ; Start serial transfer
    ld a, $81
    ldh [rSC], a

    Nops 59 + 64

    Nops 1

    ldh a, [rSB]
	cp %01000011
	
	jp nz, TestFail
	jp TestSuccess
