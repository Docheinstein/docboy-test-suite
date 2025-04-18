INCLUDE "all.inc"

; Check the timing of STAT's interrupt with different SCXs with HBlank interrupt enabled.

EntryPoint:
    Nops 123

    ld a, $06
    ldh [rSCX], a

    ld a, STATF_MODE00
    ldh [rSTAT], a

    ld a, IEF_STAT
    ldh [rIE], a

    xor a
    ldh [rIF], a

    ei

    Nops 45

    di

    jp TestFail



SECTION "STAT handler", ROM0[$48]
    jp TestSuccess

