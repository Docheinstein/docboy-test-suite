INCLUDE "all.inc"

; Check precise timing of LYC_EQ_LY for LY=9 and LYC=9.

EntryPoint:
    DisablePPU

    ; Set LYC=9
    ld a, 9
    ldh [rLYC], a

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Switch to double speed
    stop

    EnablePPU

    Wait 9 * 114 + 109
    Wait 9 * 114 + 109

    Nops 3

    ldh a, [rSTAT]
    cp $84
    jp nz, TestFail
    jp TestSuccess
