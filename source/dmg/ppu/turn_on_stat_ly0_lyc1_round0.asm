INCLUDE "docboy.inc"

; Check the value of STAT after PPU is turned on with LYC=1.

EntryPoint:
    ; Set LYC=1
    ld a, $01
    ldh [rLYC], a

    ; Reset PPU
    DisablePPU
    EnablePPU

    ; Read STAT
    ldh a, [rSTAT]
    ld b, a

    ; Check result
    ld a, $80
    cp b
    jp nz, TestFail

    jp TestSuccess