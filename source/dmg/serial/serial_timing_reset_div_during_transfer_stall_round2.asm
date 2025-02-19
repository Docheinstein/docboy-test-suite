INCLUDE "all.inc"
	
; Check the timing of serial transfer if DIV is reset during a transfer.

EntryPoint:
   ; Enable SERIAL interrupt
    ld a, IEF_SERIAL
    ldh [rIE], a

    xor a
    ldh [rIF], a

    ld bc, $00

    ei

    ; Start serial transfer
    ld a, $81
    ldh [rSC], a

Loop:
    ldh [rDIV], a
    Nops 23

    inc bc
    jp Loop

	jp TestFail

TestFinish:
    ld a, $00
    cp b
    jp nz, TestFail

    ld a, $10
    cp c
    jp nz, TestFail

    jp TestSuccess

SECTION "Serial handler", ROM0[$58]
    jp TestFinish
