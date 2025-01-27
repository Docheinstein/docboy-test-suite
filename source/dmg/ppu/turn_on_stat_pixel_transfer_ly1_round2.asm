INCLUDE "docboy.inc"

; Check the value of STAT at Pixel Transfer at LY=1 after PPU is turned on.

EntryPoint:
    ; Reset PPU
    DisablePPU
    EnablePPU

    Nops 129

    ; Read STAT
    ld hl, rSTAT
    ld a, [hl]
    ld b, a

    ; Check result
    ld a, $83
    cp b
    jp nz, TestFail

    jp TestSuccess