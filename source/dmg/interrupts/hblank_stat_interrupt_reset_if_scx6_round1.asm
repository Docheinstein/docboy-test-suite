INCLUDE "all.inc"

; Reset IF after Pixel Transfer for different SCXs with HBlank interrupt enabled.

EntryPoint:
    Wait 123

    ld a, $06
    ldh [rSCX], a

    ld a, STATF_MODE00
    ldh [rSTAT], a

    ld a, IEF_STAT
    ldh [rIE], a

    xor a
    ldh [rIF], a

    ei

    Wait 40

    ; Reset IF
    xor a
    ldh [rIF], a

    Wait 3

    jp TestFail



SECTION "STAT handler", ROM0[$48]
    jp TestSuccess

