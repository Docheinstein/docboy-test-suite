INCLUDE "all.inc"

; Check the phase of PPU at boot time in DMG mode.

EntryPoint:
    Wait 476
    ld a, [rSTAT]
    cp $85

    jp nz, TestFail
    jp TestSuccess
