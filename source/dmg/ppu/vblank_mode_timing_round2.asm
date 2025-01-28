INCLUDE "all.inc"

; Check how much time it takes to read VBLANK mode.

EntryPoint:
    ; Wait last line
    WaitScanline $8f

    ; 105 nops should read VBLANK.
    Nops 105

    ; Check result
    ldh a, [rSTAT]
    ld b, a
    ld a, $81
    cp b
    jp nz, TestFail

    jp TestSuccess