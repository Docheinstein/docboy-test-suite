INCLUDE "all.inc"

; Check the timing of STAT's interrupt with OAM interrupt enabled.

EntryPoint:
    Nops 140

    ld a, $00
    ldh [rSCX], a

    ld a, STATF_MODE10
    ldh [rSTAT], a

    ld a, IEF_STAT
    ldh [rIE], a

    xor a
    ldh [rIF], a

    ei

    Nops 77

    di

    jp TestFail



SECTION "STAT handler", ROM0[$48]
    jp TestSuccess

