INCLUDE "docboy.inc"

; Check what happens if BCPS address overflows.

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

    ld a, $bf
    ldh [rBCPS], a

    ; Write BCPD[63]
    ld a, $66
    ldh [rBCPD], a

    ; Write BCPD[64 == 0]
    ld a, $77
    ldh [rBCPD], a

    ; Read BCPD[0]
    ld a, 0
    ldh [rBCPS], a
    ldh a, [rBCPD]

    cp $77
    jp nz, TestFail

    jp TestSuccess