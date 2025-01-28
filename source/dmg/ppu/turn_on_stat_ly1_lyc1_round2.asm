INCLUDE "all.inc"

; Check the value of STAT at LY=1 after PPU is turned on with LYC=1.

EntryPoint:
    ; Set LYC=1
    ld a, $01
    ldh [rLYC], a

    ; Reset PPU
    DisablePPU
    EnablePPU

    ; Wait LY=1
    Nops 111

    ; Read STAT
    ldh a, [rSTAT]
    ld b, a

    ; Check result
    ld a, $86
    cp b
    jp nz, TestFail

    jp TestSuccess