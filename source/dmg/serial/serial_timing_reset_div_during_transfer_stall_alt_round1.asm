INCLUDE "all.inc"
	
; Check the timing of serial transfer if DIV is reset during a transfer.

EntryPoint:
    ; Start serial transfer
    ld a, $81
    ldh [rSC], a

Loop:
    ldh [rDIV], a
    Wait 29

REPT 128
    ldh [rDIV], a
    Wait 28
ENDR

    Wait 863

    ld a, [rSC]
    cp $ff

    jp nz, TestFail
	jp TestSuccess
