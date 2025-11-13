INCLUDE "all.inc"

; Check that if OBJP is written and read, it yields the same result
; for the first 7 bytes, while the last byte remains as it was.


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

MACRO SetAndCheckOBJP
    ld a, \1 * 8 + 7
    ldh [rOCPS], a
    ldh a, [rOCPD]
    ld d, a

    SetOBJP \1, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    CheckOBJP \1, $ff, $ff, $ff, $ff, $ff, $ff, $ff, d
ENDM

EntryPoint:
    DisablePPU

    SetAndCheckOBJP 0
    SetAndCheckOBJP 1
    SetAndCheckOBJP 2
    SetAndCheckOBJP 3
    SetAndCheckOBJP 4
    SetAndCheckOBJP 5
    SetAndCheckOBJP 6
    SetAndCheckOBJP 7

    jp TestSuccess