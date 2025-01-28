INCLUDE "all.inc"

; Check that BCPS auto increment works.

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