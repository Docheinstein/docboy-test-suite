INCLUDE "all.inc"

; Check that OCPS auto increment works.

; Args:
; \1: palette address
; \2: expected value
MACRO CheckOCPD
    ld a, \1
    ldh [rOCPS], a
    ldh a, [rOCPD]

    cp \2
    jp nz, TestFail
ENDM


; Args:
; \1: palette number
; \2: color 0 upper byte
; \3: color 0 lower byte
; \4: color 1 upper byte
; \5: color 1 lower byte
; \6: color 2 upper byte
; \7: color 2 lower byte
; \8: color 3 upper byte
; \9: color 3 lower byte
MACRO CheckOBJP
    CheckOCPD 8 * \1,     \2
    CheckOCPD 8 * \1 + 1, \3
    CheckOCPD 8 * \1 + 2, \4
    CheckOCPD 8 * \1 + 3, \5
    CheckOCPD 8 * \1 + 4, \6
    CheckOCPD 8 * \1 + 5, \7
    CheckOCPD 8 * \1 + 6, \8
    CheckOCPD 8 * \1 + 7, \9
ENDM

MACRO SetOBJP_AutoIncrement
    ; Color 0
    ld a, $80 | 8 * \1
    ldh [rOCPS], a

    ld a, \2
    ldh [rOCPD], a

    ld a, \3
    ldh [rOCPD], a

    ld a, \4
    ldh [rOCPD], a

    ld a, \5
    ldh [rOCPD], a

    ld a, \6
    ldh [rOCPD], a

    ld a, \7
    ldh [rOCPD], a

    ld a, \8
    ldh [rOCPD], a

    ld a, \9
    ldh [rOCPD], a
ENDM

EntryPoint:
    DisablePPU

    SetOBJP_AutoIncrement 0, $01, $3f, $ab, $22, $a5, $f2, $27, $2e
    CheckOBJP 0, $01, $3f, $ab, $22, $a5, $f2, $27, $2e

    jp TestSuccess