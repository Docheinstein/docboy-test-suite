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

MACRO CheckBCPD
    ld a, \1
    ldh [rBCPS], a
    ldh a, [rBCPD]

    cp \2
    jp nz, TestFailCGB
ENDM

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

MACRO CheckOCPD
    ld a, \1
    ldh [rOCPS], a
    ldh a, [rOCPD]

    cp \2
    jp nz, TestFailCGB
ENDM

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

TestFailCGB:
    DisablePPU
    SetBGP 0, $ff, $ff, $00, $00, $00, $00, $00, $00
    EnablePPU
    xor a
    ldh [rVBK], a
    jp TestFail

TestSuccessCGB:
    DisablePPU
    SetBGP 0, $ff, $ff, $00, $00, $00, $00, $00, $00
    EnablePPU
    xor a
    ldh [rVBK], a
    jp TestSuccess