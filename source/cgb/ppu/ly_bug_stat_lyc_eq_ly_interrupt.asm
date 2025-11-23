INCLUDE "all.inc"

; Check if LY bug affects LYC_EQ_LY STAT flag.

EntryPoint:
    DisablePPU

    EnablePPU

    ; SKip 9 lines
    Wait 9 * 114

    ; Reset IF
    xor a
    ldh [rIF], a

    ; Enable STAT interrupt
    ld a, IEF_STAT
    ldh [rIE], a

    ei

    ; Enable LYC_EQ_LY interrupt for LY = $08
    ld a, STATF_LYC
    ldh [rSTAT], a

    ld a, $08
    ldh [rLYC], a

    ld de, $00
Loop:
    inc de
    jp Loop

    jp TestFail

TestContinue:
    ld a, d
    cp $0b
    jp nz, TestFail

    ld a, e
    cp $57
    jp nz, TestFail

    jp TestSuccess

SECTION "STAT handler", ROM0[$48]
    jp TestContinue