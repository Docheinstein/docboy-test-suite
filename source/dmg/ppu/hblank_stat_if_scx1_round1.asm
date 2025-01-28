INCLUDE "all.inc"

; Check IF after Pixel Transfer for different SCXs with HBlank interrupt enabled.

EntryPoint:
    Nops 123

    ld a, $01
    ldh [rSCX], a

    ld a, STATF_MODE00
    ldh [rSTAT], a

    ld a, IEF_STAT
    ldh [rIE], a

    xor a
    ldh [rIF], a

    Nops 42

    ldh a, [rIF]
    cp $e0

    jp nz, TestFail

    jp TestSuccess
