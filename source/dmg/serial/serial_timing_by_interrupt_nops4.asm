INCLUDE "all.inc"
	
; Check the timing of serial transfer with a certain alignment.

EntryPoint:
	; Wait a certain time
	Nops 4
	
    ; Enable SERIAL interrupt
    ld a, IEF_SERIAL
    ldh [rIE], a
    
    xor a
    ldh [rIF], a

    ei

    ; Start serial transfer
    ld a, $81
    ldh [rSC], a

    ld bc, $00

REPT 1024
    inc bc
ENDR

	; We should not reach this point
    jp TestFail

TestFinish:
    ld a, $01
    cp b
    
    jp nz, TestFail
    
    ld a, $f9
	cp c
	
	jp nz, TestFail
	
	jp TestSuccess
	
SECTION "Serial handler", ROM0[$58]
    jp TestFinish
