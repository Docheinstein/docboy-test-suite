INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Check precise timing of LYC_EQ_LY for LYC=0 and LY=153.

EntryPoint:
    DisablePPU

    ; Set LYC=0
    ld a, $00
    ldh [rLYC], a

    EnablePPU

    LongWait 152 * 114 + 113

    ; Read LYC_EQ_LY from stat: it should be 1
    ldh a, [rSTAT]
    cp $85

    jp nz, TestFail
    jp TestSuccess
