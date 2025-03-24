INCLUDE "all.inc"

; Check the timing of LYC_EQ_LY in double speed mode by reading STAT with various SCX.

EntryPoint:
    DisablePPU

    ; Write LYC=8
    ld a, 8
    ldh [rLYC], a

    ; Enable LYC_EQ_LY interrupt
    ld a, STATF_LYC
    ldh [rSTAT], a

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Switch to double speed
    stop

    ; Enable PPU
    EnablePPU

    LongWait 228 * 7

    Nops 223

    ; Read STAT
    ldh a, [rSTAT]
    cp $c0

    jp nz, TestFail
    jp TestSuccess