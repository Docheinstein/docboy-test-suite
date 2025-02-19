INCLUDE "all.inc"
	
; Check the timing at which SB content changes.

EntryPoint:
    Nops 3

    Nops 0

    ; Start serial transfer
    ld a, $81
    ldh [rSC], a

    Nops 4 * 128

    Nops 61

    Nops 1

    ldh a, [rSB]
	cp $1f
	
	jp nz, TestFail

	ld a, %10101000
    ldh [rSB], a

    Nops 370

    ldh a, [rSB]
    cp $a3

    jp nz, TestFail
	jp TestSuccess
