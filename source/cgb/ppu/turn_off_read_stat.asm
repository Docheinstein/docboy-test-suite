INCLUDE "all.inc"

; STAT's mode should be HBlank if it is read while PPU is off.

EntryPoint:
    DisablePPU

    ; Read STAT
    ldh a, [rSTAT]

    ; Check result
    cp $80
    jp nz, TestFail

    jp TestSuccess