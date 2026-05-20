INCLUDE "all.inc"

; Check STAT after Pixel Transfer for different SCXs.

EntryPoint:
    Wait 123

    ld a, $00
    ldh [rSCX], a

    Wait 56

    ldh a, [rSTAT]
    cp $83

    jp nz, TestFail

    jp TestSuccess
