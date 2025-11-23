INCLUDE "all.inc"

; Check precise timing of LYC_EQ_LY for LY=10 and LYC=11.

EntryPoint:
    DisablePPU

    ; Set LYC=11
    ld a, 11
    ldh [rLYC], a

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Switch to double speed
    stop

    EnablePPU

    Wait 10 * 114 + 109
    Wait 10 * 114 + 109

    Nops 5

    ldh a, [rSTAT]
    cp $80
    jp nz, TestFail
    jp TestSuccess
