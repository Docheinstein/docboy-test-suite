INCLUDE "docboy.inc"

; Check the value of STAT at LY=1 after PPU is turned on with LYC=0.

EntryPoint:
    ; Set LYC=0
    xor a
    ldh [rLYC], a

    ; Reset PPU
    DisablePPU
    EnablePPU

    ; Wait LY=1
    Nops 110

    ; Read STAT
    ldh a, [rSTAT]
    ld b, a

    ; Check result
    ld a, $80
    cp b
    jp nz, TestFail

    jp TestSuccess