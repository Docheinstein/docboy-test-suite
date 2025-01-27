DEF CGB = 1

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
MACRO SetBGP
    ; Color 0
    ld a, 8 * \1
    ldh [rBCPS], a

    ld a, \2
    ldh [rBCPD], a

    ld a, 8 * \1 + 1
    ldh [rBCPS], a

    ld a, \3
    ldh [rBCPD], a

    ; Color 1
    ld a, 8 * \1 + 2
    ldh [rBCPS], a

    ld a, \4
    ldh [rBCPD], a

    ld a, 8 * \1 + 3
    ldh [rBCPS], a

    ld a, \5
    ldh [rBCPD], a

    ; Color 2
    ld a, 8 * \1 + 4
    ldh [rBCPS], a

    ld a, \6
    ldh [rBCPD], a

    ld a, 8 * \1 + 5
    ldh [rBCPS], a

    ld a, \7
    ldh [rBCPD], a

    ; Color 3
    ld a, 8 * \1 + 6
    ldh [rBCPS], a

    ld a, \8
    ldh [rBCPD], a

    ld a, 8 * \1 + 7
    ldh [rBCPS], a

    ld a, \9
    ldh [rBCPD], a
ENDM

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
MACRO SetOBJP
    ; Color 0
    ld a, 8 * \1
    ldh [rOCPS], a

    ld a, \2
    ldh [rOCPD], a

    ld a, 8 * \1 + 1
    ldh [rOCPS], a

    ld a, \3
    ldh [rOCPD], a

    ; Color 1
    ld a, 8 * \1 + 2
    ldh [rOCPS], a

    ld a, \4
    ldh [rOCPD], a

    ld a, 8 * \1 + 3
    ldh [rOCPS], a

    ld a, \5
    ldh [rOCPD], a

    ; Color 2
    ld a, 8 * \1 + 4
    ldh [rOCPS], a

    ld a, \6
    ldh [rOCPD], a

    ld a, 8 * \1 + 5
    ldh [rOCPS], a

    ld a, \7
    ldh [rOCPD], a

    ; Color 3
    ld a, 8 * \1 + 6
    ldh [rOCPS], a

    ld a, \8
    ldh [rOCPD], a

    ld a, 8 * \1 + 7
    ldh [rBCPS], a

    ld a, \9
    ldh [rOCPD], a
ENDM

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

MACRO SetDefaultBGP
    SetBGP 0, $ff, $ff, $00, $00, $00, $00, $00, $00
ENDM