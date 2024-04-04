INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Check precise timing of LYC_EQ_LY for LY=LYC=0 for last scanline.

EntryPoint:
    ResetPPU

    LongWait 152 * 114 + 111

    ; Read LYC_EQ_LY from stat: it should be 0
    ldh a, [rSTAT]
    cp $81
    jp nz, TestFail
    jp TestSuccess
