INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Check precise timing of LYC_EQ_LY for LYC=152 and LY=152.

EntryPoint:
    DisablePPU

    ; Set LYC=152
    ld a, $98
    ldh [rLYC], a

    EnablePPU

    LongWait 151 * 114 + 110

    ; Read LYC_EQ_LY from stat: it should be 0
    ldh a, [rSTAT]
    cp $81

    jp nz, TestFail
    jp TestSuccess
