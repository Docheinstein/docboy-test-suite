IF !DEF(MEMORY_INC)
DEF MEMORY_INC EQU 1

; Args:
; \1: destination address
; \2: value
; \3: length
MACRO Memset
    ld hl, \1 ; destination address
    ld b,  \2 ; value
    ld de, \3 ; length

.loop\@
    ; Set [HL++]=value
    ld a, b
	ld [hli], a

	; Restart if DE != 0
	dec de
	ld a, d
	or e
	jp nz, .loop\@
ENDM


; Args:
; \1: destination address
; \2: source address
; \3: length
MACRO Memcpy
    ld hl, \1 ; destination address
    ld bc, \2 ; source address
    ld de, \3 ; length

.loop\@
    ; Transfer one byte: [HL++]=[BC++]
    ld a, [bc]
    inc bc
	ld [hli], a

	; Restart if DE != 0
	dec de
	ld a, d
	or e
	jp nz, .loop\@
ENDM


; Args:
; \1: first address
; \2: second address
; \3: length
; Output:
; Z=0 if success
MACRO Memcmp
    ld hl, \1 ; first address
    ld bc, \2 ; second address
    ld de, \3 ; length

.loop\@
    ; Compare one byte
    ld a, [bc]
	cp [hl]
	jp nz, .fail\@

    inc bc
    inc hl

	; Restart if DE != 0
	dec de
	ld a, d
	or e
	jp nz, .loop\@

	xor a
	jp .end\@

.fail\@
    xor a
    inc a
.end\@
ENDM


; Args:
; \1: first address
; \2: value
; \3: length
; Output:
; Z=0 if success
MACRO Memtest
    ld hl, \1 ; first address
    ld b, \2  ; value
    ld de, \3 ; length

.loop\@
    ; Compare one byte
    ldi a, [hl]
    cp b
	jp nz, .fail\@

	; Restart if DE != 0
	dec de
	ld a, d
	or e
	jp nz, .loop\@

	xor a
	jp .end\@

.fail\@
    xor a
    inc a
.end\@
ENDM


; Args:
; \1: address
; \2: expected value
; Output
; Z=0 if success
MACRO Memcheck
    ld hl, \1 ; address
    ld b,  \2 ; expected value

    ; Compare byte
    ld a, [hl]
	cp b
	jp nz, .fail\@

	xor a
	jp .end\@

.fail\@
    xor a
    inc a
.end\@
ENDM

ENDC