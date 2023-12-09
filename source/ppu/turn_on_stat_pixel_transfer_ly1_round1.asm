INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Check the value of STAT at Pixel Transfer at LY=1 after PPU is turned on.

EntryPoint:
    DisablePPU
    EnablePPU

    Nops 128

    ; Read STAT
    ld hl, rSTAT
    ld a, [hl]
    ld b, a

    ; Check result
    ld a, $82
    cp b
    jp nz, TestFail

    jp TestSuccess