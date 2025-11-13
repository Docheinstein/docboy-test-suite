INCLUDE "all.inc"

; Check the initial value of BG palettes.
; They should be all white (FF7F).

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

EntryPoint:
    DisablePPU

    FOR I, 32
        CheckBCPD 2 * I + 0, $ff
        CheckBCPD 2 * I + 1, $7f
    ENDR

    jp TestSuccess
