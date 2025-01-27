INCLUDE "docboy.inc"

; Check the value of IF after PPU is turned on with LYC=0.
; The STAT interrupt should not be raised because of LYC_EQ_LY.

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

    ; Read IF
    ldh a, [rIF]
    ld b, a

    ; Check result
    ld a, $e0
    cp b
    jp nz, TestFail

    jp TestSuccess