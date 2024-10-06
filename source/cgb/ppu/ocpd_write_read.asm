INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "vram.inc"
INCLUDE "dma.inc"
INCLUDE "cgb.inc"

; Check that if OBJP is written and read, it yields the same result
; for the first 7 bytes, while the last byte remains as it was.

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

    jp TestSuccessCGB