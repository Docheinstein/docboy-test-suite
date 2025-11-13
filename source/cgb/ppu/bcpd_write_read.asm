INCLUDE "all.inc"

; Check that if BGP is written and read, it yields the same result.

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

EntryPoint:
    DisablePPU

    SetBGP 0, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    SetBGP 1, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    SetBGP 2, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    SetBGP 3, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    SetBGP 4, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    SetBGP 5, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    SetBGP 6, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    SetBGP 7, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff

    CheckBGP 0, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    CheckBGP 1, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    CheckBGP 2, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    CheckBGP 3, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    CheckBGP 4, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    CheckBGP 5, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    CheckBGP 6, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    CheckBGP 7, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff

    SetBGP 0, $00, $00, $00, $00, $00, $00, $00, $00,
    SetBGP 1, $00, $00, $00, $00, $00, $00, $00, $00,
    SetBGP 2, $00, $00, $00, $00, $00, $00, $00, $00,
    SetBGP 3, $00, $00, $00, $00, $00, $00, $00, $00,
    SetBGP 4, $00, $00, $00, $00, $00, $00, $00, $00,
    SetBGP 5, $00, $00, $00, $00, $00, $00, $00, $00,
    SetBGP 6, $00, $00, $00, $00, $00, $00, $00, $00,
    SetBGP 7, $00, $00, $00, $00, $00, $00, $00, $00,

    CheckBGP 0, $00, $00, $00, $00, $00, $00, $00, $00,
    CheckBGP 1, $00, $00, $00, $00, $00, $00, $00, $00,
    CheckBGP 2, $00, $00, $00, $00, $00, $00, $00, $00,
    CheckBGP 3, $00, $00, $00, $00, $00, $00, $00, $00,
    CheckBGP 4, $00, $00, $00, $00, $00, $00, $00, $00,
    CheckBGP 5, $00, $00, $00, $00, $00, $00, $00, $00,
    CheckBGP 6, $00, $00, $00, $00, $00, $00, $00, $00,
    CheckBGP 7, $00, $00, $00, $00, $00, $00, $00, $00,

    jp TestSuccess