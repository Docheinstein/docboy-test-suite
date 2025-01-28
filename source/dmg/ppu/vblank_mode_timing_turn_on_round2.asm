INCLUDE "all.inc"

; Check how much time it takes to read VBLANK mode after PPU is turned on.

EntryPoint:
    ; Reset PPU
    DisablePPU
    EnablePPU

    ; Wait last line
    WaitScanline $8f

    ; 102 nops should read VBLANK.
    Nops 102

    ; Check result
    ldh a, [rSTAT]
    ld b, a
    ld a, $81
    cp b
    jp nz, TestFail

    jp TestSuccess