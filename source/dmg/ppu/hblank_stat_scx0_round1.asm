INCLUDE "all.inc"

; Check STAT after Pixel Transfer for different SCXs.

EntryPoint:
    Nops 123

    ld a, $00
    ldh [rSCX], a

    Nops 56

    ldh a, [rSTAT]
    cp $83

    jp nz, TestFail

    jp TestSuccess
