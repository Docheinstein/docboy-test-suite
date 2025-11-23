INCLUDE "all.inc"

; Check precise timing of LYC_EQ_LY for LY=10 and LYC=10.

EntryPoint:
    DisablePPU

    ; Set LYC=10
    ld a, 10
    ldh [rLYC], a

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Switch to double speed
    stop

    EnablePPU

    Wait 10 * 114 + 109
    Wait 10 * 114 + 109

    Nops 6

    ldh a, [rSTAT]
    cp $82
    jp nz, TestFail
    jp TestSuccess
