INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Check the value of STAT after PPU is turned off with with LY=2 and LYC=0.
; The STAT's LYC_EQ_LY flag should be reset (even if LY and LYC match).

EntryPoint:
    xor a
    ldh [rLYC], a

    WaitScanline 2

    DisablePPU

    Nops 2

    ; Read STAT
    ldh a, [rSTAT]
    ld b, a

    ; Check result
    ld a, $80
    cp b
    jp nz, TestFail


    jp TestSuccess