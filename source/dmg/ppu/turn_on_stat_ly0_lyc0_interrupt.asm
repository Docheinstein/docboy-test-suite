INCLUDE "all.inc"

; Check that STAT interrupt is not raised after PPU is turned on with LYC=0.

EntryPoint:
    ; Set LYC=0
    xor a
    ldh [rLYC], a

    ; Set STAT' LYC_EQ_LY_INTERRUPT=1
    ld a, $40
    ldh [rSTAT], a

    ; Set IF=0
    ldh [rIF], a

    ; Reset PPU
    DisablePPU
    EnablePPU

    Nops 4

    jp TestSuccess


SECTION "STAT handler", ROM0[$48]
    ; This should not be triggered
    jp TestFail
