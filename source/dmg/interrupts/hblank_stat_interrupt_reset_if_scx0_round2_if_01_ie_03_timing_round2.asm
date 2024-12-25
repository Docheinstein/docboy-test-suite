INCLUDE "hardware.inc"
INCLUDE "common.inc"

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

    ; Reset DIV
    xor a
    ldh [rDIV], a

    ; Reset TIMA
    ldh [rTIMA], a

    ; Enable timer at 262KHZ Hz
    ld a, TACF_START | TACF_262KHZ
    ldh [rTAC], a

    Nops 28

    ; Reset IF
    ld a, $01
    ldh [rIF], a

    Nops 3

    jp TestFail


TestContinue:
    Nops 3

    ldh a, [rTIMA]
    cp $0c

    jp nz, TestFail

    jp TestSuccess

SECTION "VBlank handler", ROM0[$40]
    jp TestContinue

SECTION "STAT handler", ROM0[$48]
    jp TestFail

