INCLUDE "all.inc"
	
; Check the timing of serial transfer if DIV is reset during a transfer.

EntryPoint:
    ; Start serial transfer
    ld a, $81
    ldh [rSC], a

Loop:
    ldh [rDIV], a
    Nops 29

REPT 128
    ldh [rDIV], a
    Nops 28
ENDR

    Nops 864

    ld a, [rSC]
    cp $7f

    jp nz, TestFail
	jp TestSuccess