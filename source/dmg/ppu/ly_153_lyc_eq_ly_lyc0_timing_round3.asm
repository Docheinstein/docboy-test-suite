INCLUDE "all.inc"

; Check precise timing of LYC_EQ_LY for LYC=0 and LY=153.

EntryPoint:
    DisablePPU

    ; Set LYC=0
    ld a, $00
    ldh [rLYC], a

    EnablePPU

    Wait 152 * 114 + 112

    ; Read LYC_EQ_LY from stat: it should be 0
    ldh a, [rSTAT]
    cp $81

    jp nz, TestFail
    jp TestSuccess
