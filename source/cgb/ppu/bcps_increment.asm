INCLUDE "all.inc"

; Check that BCPS auto increment works.

; Args:
; \1: palette address
; \2: expected value
MACRO CheckBCPD
    ld a, \1
    ldh [rBCPS], a
    ldh a, [rBCPD]

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
MACRO CheckBGP
    CheckBCPD 8 * \1,     \2
    CheckBCPD 8 * \1 + 1, \3
    CheckBCPD 8 * \1 + 2, \4
    CheckBCPD 8 * \1 + 3, \5
    CheckBCPD 8 * \1 + 4, \6
    CheckBCPD 8 * \1 + 5, \7
    CheckBCPD 8 * \1 + 6, \8
    CheckBCPD 8 * \1 + 7, \9
ENDM

MACRO SetBGP_AutoIncrement
    ; Color 0
    ld a, $80 | 8 * \1
    ldh [rBCPS], a

    ld a, \2
    ldh [rBCPD], a

    ld a, \3
    ldh [rBCPD], a

    ld a, \4
    ldh [rBCPD], a

    ld a, \5
    ldh [rBCPD], a

    ld a, \6
    ldh [rBCPD], a

    ld a, \7
    ldh [rBCPD], a

    ld a, \8
    ldh [rBCPD], a

    ld a, \9
    ldh [rBCPD], a
ENDM

EntryPoint:
    DisablePPU

    SetBGP_AutoIncrement 0, $01, $3f, $ab, $22, $a5, $f2, $27, $2e
    CheckBGP 0, $01, $3f, $ab, $22, $a5, $f2, $27, $2e

    jp TestSuccess