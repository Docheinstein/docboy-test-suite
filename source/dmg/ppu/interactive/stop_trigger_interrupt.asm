INCLUDE "all.inc"

; STOP with PPU enabled and LYC_EQ_LY enabled for a line that is covered by the PPU while it runs during STOP mode.
; Interrupt should be triggered as soon as STOP mode is exited.

EntryPoint:
    ; Enable STAT interrupt
    ld a, IEF_STAT
    ldh [rIE], a

    xor a
    ldh [rIF], a

    ; Write LYC=30
    ld a, 30
    ldh [rLYC], a

    ; Enable LYC_EQ_LY interrupt
    ld a, STATF_LYC
    ldh [rSTAT], a

    ei

    DisablePPU
    EnablePPU

    ; Go to line 20
    Wait 20 * 114

    stop

    Nops 16

    jp TestFail

SECTION "STAT handler", ROM0[$48]
    jp TestSuccess