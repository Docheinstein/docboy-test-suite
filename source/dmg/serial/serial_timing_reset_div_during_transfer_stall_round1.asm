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

    ; Resetting DIV with this timing prevents serial tranfser to proceed further.
REPT 128
    ldh [rDIV], a
    Nops 22

    inc bc
ENDR

    ld a, [rSC]
    cp $ff
    jp nz, TestFail

    ld a, [rSB]
    cp $00
    jp nz, TestFail

	jp TestSuccess


SECTION "Serial handler", ROM0[$58]
    jp TestFail