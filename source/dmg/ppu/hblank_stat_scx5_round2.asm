INCLUDE "all.inc"

; Check STAT after Pixel Transfer for different SCXs.

EntryPoint:
    Wait 123

    ld a, $05
    ldh [rSCX], a

    Wait 58

    ldh a, [rSTAT]
    cp $80

    jp nz, TestFail

    jp TestSuccess
