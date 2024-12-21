INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Check STAT after Pixel Transfer for different SCXs.

EntryPoint:
    Nops 123

    ld a, $06
    ldh [rSCX], a

    Nops 58

    ldh a, [rSTAT]
    cp $80

    jp nz, TestFail

    jp TestSuccess