INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Check STAT after Pixel Transfer for different SCXs.

EntryPoint:
    Nops 123

    ld a, $01
    ldh [rSCX], a

    Nops 57

    ldh a, [rSTAT]
    cp $80

    jp nz, TestFail

    jp TestSuccess
