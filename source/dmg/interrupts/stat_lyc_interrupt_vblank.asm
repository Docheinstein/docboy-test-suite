INCLUDE "docboy.inc"

; Check that LYC_EQ_LY for LY=LYC=0 triggers only once when passing through VBlank.

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

    ld b, 0

StartWait:
    ; Go to line 8 of next frame
    LongWait 162 * 114

    ld a, b
    cp 1
    jp nz, TestFail
    jp TestSuccess


SECTION "STAT handler", ROM0[$48]
    inc b
    reti
