INCLUDE "all.inc"

; Reset IF after Pixel Transfer for different SCXs with HBlank interrupt enabled.

EntryPoint:
    Nops 123

    ld a, $00
    ldh [rSCX], a

    ld a, STATF_MODE00
    ldh [rSTAT], a

    ld a, IEF_STAT | IEF_VBLANK
    ldh [rIE], a

    xor a
    ldh [rIF], a

    ei

    Nops 40

    ; Reset IF
    ld a, $01
    ldh [rIF], a

    di

    jp TestFail


SECTION "VBlank handler", ROM0[$40]
    jp TestSuccess

SECTION "STAT handler", ROM0[$48]
    jp TestFail




