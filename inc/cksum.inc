; Args:
; \1: address
; \2: length
; Output:
; A: contains checksum
MACRO Checksum
    ld hl, \1 ; address
    ld bc, \2 ; length

    ld de, $00 ; checksum

.loop\@
    ; D = (D + [HL++]) << 1
	ld a, [hli]
	add d
	rlca
	ld d, a

	; Restart if BC != 0
	dec bc
	ld a, b
	or c
	jp nz, .loop\@

	; Set result to A
	ld a, d
ENDM