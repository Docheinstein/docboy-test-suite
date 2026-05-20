INCLUDE "all.inc"

; Check STAT after Pixel Transfer for different SCXs.

EntryPoint:
    Wait 123

    ld a, $03
    ldh [rSCX], a

    Wait 57

    ldh a, [rSTAT]
    cp $80

    jp nz, TestFail

    jp TestSuccess
