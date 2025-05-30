INCLUDE "all.inc"

; Reset IE after Pixel Transfer for different SCXs with HBlank interrupt enabled.

EntryPoint:
    Nops 123

    ld a, $07
    ldh [rSCX], a

    ld a, STATF_MODE00
    ldh [rSTAT], a

    ld a, IEF_STAT
    ldh [rIE], a

    xor a
    ldh [rIF], a

    ei

    Nops 45

    ; Reset IE
    xor a
    ldh [rIE], a

    Nops 3

    jp TestFail



SECTION "STAT handler", ROM0[$48]
    jp TestSuccess

