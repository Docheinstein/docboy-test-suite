INCLUDE "all.inc"

; Check the phase of PPU at boot time.

EntryPoint:
    Wait 978
    ld a, [rSTAT]

    cp $81
    jp nz, TestFail

    jp TestSuccess
