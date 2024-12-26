INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Reset IF after Pixel Transfer for different SCXs with HBlank interrupt enabled.

EntryPoint:
    Nops 123

    ld a, $00
    ldh [rSCX], a

    ld a, STATF_MODE00
    ldh [rSTAT], a

    ld a, IEF_STAT
    ldh [rIE], a

    xor a
    ldh [rIF], a

    ei

    Nops 40

    ; Reset IF
    ld a, $00
    ldh [rIF], a

    Nops 3

    jp TestSuccess



SECTION "STAT handler", ROM0[$48]
    jp TestFail
