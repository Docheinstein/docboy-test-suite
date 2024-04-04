INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Check precise timing of LY for last scanline.
; LY should be proceed as 152 -> 153 -> 0 in three M-cycles.

EntryPoint:
    ResetPPU

    LongWait 152 * 114 + 111

    ; Read LY: it should read LY=154
    ldh a, [rLY]
    cp $00
    jp nz, TestFail
    jp TestSuccess
