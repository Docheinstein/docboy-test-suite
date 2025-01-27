INCLUDE "docboy.inc"

; Ensure that STAT is written even if PPU is off.

EntryPoint:
    DisablePPU

    xor a
    ldh [rSTAT], a

    ldh a, [rSTAT]
    cp $84

    jp nz, TestFail

    jp TestSuccess