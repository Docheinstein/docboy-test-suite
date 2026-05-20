INCLUDE "all.inc"

; Reset IF when mode is entering OAM.

EntryPoint:
    Wait 114

    ; Reset IF
    xor a
    ldh [rIF], a

    ; Enable STAT interrupt
    ld a, IEF_STAT
    ldh [rIE], a

    ; Enable OAM interrupt
    ld a, STATF_MODE10
    ldh [rSTAT], a

    ei

    Wait 107

    ; Reset IF
    xor a
    ldh [rIF], a

    ; Read IF
    Wait 3

    jp TestFail


SECTION "STAT handler", ROM0[$48]
    jp TestSuccess