INCLUDE "all.inc"

; Check IF after Pixel Transfer for different SCXs with HBlank interrupt enabled.

EntryPoint:
    Nops 123

    ld a, $04
    ldh [rSCX], a

    ld a, STATF_MODE00
    ldh [rSTAT], a

    ld a, IEF_STAT
    ldh [rIE], a

    xor a
    ldh [rIF], a

    ei

    Nops 44

    di

    jp TestSuccess



SECTION "STAT handler", ROM0[$48]
    jp TestFail

