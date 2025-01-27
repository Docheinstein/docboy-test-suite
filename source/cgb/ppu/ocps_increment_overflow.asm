INCLUDE "docboy.inc"

; Check what happens if OCPS address overflows.

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

    ld a, $bf
    ldh [rOCPS], a

    ; Write BCPD[63]
    ld a, $66
    ldh [rOCPD], a

    ; Write BCPD[64 == 0]
    ld a, $77
    ldh [rOCPD], a

    ; Read BCPD[0]
    ld a, 0
    ldh [rOCPS], a
    ldh a, [rOCPD]

    cp $77
    jp nz, TestFail

    jp TestSuccess