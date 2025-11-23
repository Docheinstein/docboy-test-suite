INCLUDE "all.inc"

; Check precise timing of LYC_EQ_LY for LY=9 and LYC=8.

EntryPoint:
    DisablePPU

    ; Set LYC=8
    ld a, 8
    ldh [rLYC], a

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Switch to double speed
    stop

    EnablePPU

    Wait 9 * 114 + 109
    Wait 9 * 114 + 109

    Nops 4

    ldh a, [rSTAT]
    cp $80
    jp nz, TestFail
    jp TestSuccess
