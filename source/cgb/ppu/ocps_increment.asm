INCLUDE "docboy.inc"

; Check that OCPS auto increment works.

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