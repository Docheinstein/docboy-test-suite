INCLUDE "all.inc"

; Check the value of STAT at Pixel Transfer at LY=0 after PPU is turned on.

EntryPoint:
    ; Reset PPU
    DisablePPU
    EnablePPU

    ; Read STAT
    ld hl, rSTAT
    ld a, [hl]
    ld b, a

    ; Check result
    ld a, $84
    cp b
    jp nz, TestFail

    jp TestSuccess