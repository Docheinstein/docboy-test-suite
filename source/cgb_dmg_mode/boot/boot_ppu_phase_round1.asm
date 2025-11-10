INCLUDE "all.inc"

; Check the phase of PPU at boot time in DMG mode.

EntryPoint:
    Wait 475
    ld a, [rSTAT]
    cp $81

    jp nz, TestFail
    jp TestSuccess
