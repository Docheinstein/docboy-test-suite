INCLUDE "all.inc"

; Check the phase of PPU at boot time.

EntryPoint:
    Wait 979
    ld a, [rSTAT]

    cp $85
    jp nz, TestFail

    jp TestSuccess
