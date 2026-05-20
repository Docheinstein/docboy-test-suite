INCLUDE "all.inc"

; Check IF after Pixel Transfer for different SCXs with HBlank interrupt enabled.

EntryPoint:
    Wait 123

    ld a, $01
    ldh [rSCX], a

    ld a, STATF_MODE00
    ldh [rSTAT], a

    ld a, IEF_STAT
    ldh [rIE], a

    xor a
    ldh [rIF], a

    Wait 43

    ldh a, [rIF]
    cp $e2

    jp nz, TestFail

    jp TestSuccess
