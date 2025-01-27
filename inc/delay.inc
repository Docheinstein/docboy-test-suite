; Args:
; \1: number of nops
MACRO Nops
REPT \1
    nop
ENDR
ENDM

MACRO LongWait
; Args:
; \1: number of cycles to wait (MUST BE > 8)
ld de, ((\1) / 8) - ((\1) % 8 < 2)   ; 3

.loop\@
	dec de            ; 2
	ld a, d           ; 1
	or e              ; 1
	jp nz, .loop\@    ; 3/4

REPT (((\1) % 8) + 8 - 2) % 8
    nop
ENDR
ENDM