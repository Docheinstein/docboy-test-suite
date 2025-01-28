INCLUDE "all.inc"

; LY should be increased at dot 454.

EntryPoint:
    ; Reset IF
    xor a
    ldh [rIF], a

    ; Enable STAT interrupt
    ld a, IEF_STAT
    ldh [rIE], a

    ; Enable OAM interrupt
    ld a, STATF_MODE10
    ldh [rSTAT], a

    ; 106 nops should not be enough for LY to be increased
    Nops 106

    ; Read IF
    ldh a, [rLY]
    ld b, a

    ; Check result
    xor 0
    cp b
    jp nz, TestFail

    jp TestSuccess
