INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Check how much time it takes to read VBLANK mode.

EntryPoint:
    ; Wait last line
    WaitScanline $8f

    ; 104 nops should read HBLANK.
    Nops 104

    ; Check result
    ldh a, [rSTAT]
    ld b, a
    ld a, $80
    cp b
    jp nz, TestFail

    jp TestSuccess