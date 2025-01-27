INCLUDE "docboy.inc"

; Check the value of STAT after PPU is turned off with with LY=2 and LYC=1.
; The STAT's LYC_EQ_LY flag should remain 0.

EntryPoint:
    ld a, $01
    ldh [rLYC], a

    WaitScanline 2

    DisablePPU

    Nops 2

    ; Read STAT
    ldh a, [rSTAT]
    ld b, a

ReadIt:
    ; Check result
    ld a, $80
    cp b
    jp nz, TestFail


    jp TestSuccess