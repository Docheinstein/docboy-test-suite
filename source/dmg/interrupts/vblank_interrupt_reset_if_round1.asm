INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Reset IF when mode is entering VBlank.

EntryPoint:
    ; Reset IF
    xor a
    ldh [rIF], a

    ; Enable STAT interrupt
    ld a, IEF_VBLANK
    ldh [rIE], a

    ei

    LongWait 114 * 143 + 109

    ; Reset IF
    xor a
    ldh [rIF], a

    ; Read IF
    Nops 3

    jp TestFail


SECTION "STAT handler", ROM0[$48]
    jp TestSuccess