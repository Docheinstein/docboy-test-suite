INCLUDE "all.inc"

; Check the timing of STAT's LYC_EQ_LY interrupt for LY=LYC=0 when passing through VBlank.

EntryPoint:
    ; Reset PPU
    DisablePPU
    EnablePPU

    ; Go out of first line
    Nops 114

    ; Enable interrupt
    ei

    ; Enable STAT interrupt
    ld a, IEF_STAT
    ldh [rIE], a

    ; Enable LYC_EQ_LY interrupt
    ld a, STATF_LYC
    ldh [rSTAT], a

    ; Write LYC=0
    xor a
    ldh [rLYC], a


    ; Go to line 8 of next frame
    Wait 162 * 114

    ; 56 nops should read DIV=$13
    Nops 56

    ldh a, [rDIV]
    cp $13
    jp nz, TestFail
    jp TestSuccess


SECTION "STAT handler", ROM0[$48]
    ; Reset DIV
    ldh [rDIV], a
    reti
