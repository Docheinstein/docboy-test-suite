INCLUDE "docboy.inc"

; Check the timing of LYC_EQ_LY STAT's interrupt for LY=LYC=8.

EntryPoint:
    ; Reset PPU
    DisablePPU
    EnablePPU

    LongWait 7 * 114

    ; Write LYC=8
    ld a, 8
    ldh [rLYC], a

    ; Enable LYC_EQ_LY interrupt
    ld a, STATF_LYC
    ldh [rSTAT], a

    ; Reset interrupts flag
    xor a
    ldh [rIF], a

    ; Enable STAT interrupt
    ld a, IEF_STAT
    ldh [rIE], a

    ; Enable interrupts
    ei

    ; Reset DIV
    ldh [rDIV], a

    ; Wait
    Nops 114

    ; We should not reach this point
    jp TestFail

TestFinish:
    ; 26 nops should read DIV=2
    Nops 26

    ldh a, [rDIV]
    cp $02
    jp nz, TestFail
    jp TestSuccess


SECTION "STAT handler", ROM0[$48]
    jp TestFinish
