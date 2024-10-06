INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Check how much time it takes to read VBLANK mode after PPU is turned on.

EntryPoint:
    ResetPPU

    ; Wait last line
    WaitScanline $8f

    ; 101 nops should read HBLANK.
    Nops 101

    ; Check result
    ldh a, [rSTAT]
    ld b, a
    ld a, $80
    cp b
    jp nz, TestFail

    jp TestSuccess