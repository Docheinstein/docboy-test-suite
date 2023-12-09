INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Check the value of STAT after PPU is turned off with with LY=2 and LYC=2.
; The STAT's LYC_EQ_LY flag remain set.

EntryPoint:
    ld a, $02
    ld [rLYC], a

    WaitScanline 2

    DisablePPU

    Nops 2

ReadIt:
    ; Read STAT
    ldh a, [rSTAT]
    ld b, a

    ; Check result
    ld a, $84
    cp b
    jp nz, TestFail


    jp TestSuccess