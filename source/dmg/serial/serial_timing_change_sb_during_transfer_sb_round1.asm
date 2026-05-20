INCLUDE "all.inc"
	
; Check the timing at which SB content changes.

EntryPoint:
    Wait 3

    Wait 0

    ; Start serial transfer
    ld a, $81
    ldh [rSC], a

    Wait 4 * 128

    Wait 61

    Wait 1

    ldh a, [rSB]
	cp $1f
	
	jp nz, TestFail

	ld a, %10101000
    ldh [rSB], a

    Wait 370

    ldh a, [rSB]
    cp $a3

    jp nz, TestFail
	jp TestSuccess
