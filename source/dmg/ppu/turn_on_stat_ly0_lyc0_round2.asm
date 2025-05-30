INCLUDE "all.inc"

; Check the value of STAT after PPU is turned on with LYC=0.

EntryPoint:
    ; Set LYC=0
    xor a
    ldh [rLYC], a

    ; Reset PPU
    DisablePPU
    EnablePPU

    Nops 17

    ; Read STAT
    ldh a, [rSTAT]
    ld b, a

    ; Check result
    ld a, $87
    cp b
    jp nz, TestFail

    jp TestSuccess