INCLUDE "hardware.inc"
INCLUDE "common.inc"

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

    ; 107 nops should be enough for LY to be increased
    Nops 107

    ; Read LY
    ldh a, [rLY]
    ld b, a

    ; Check result
    ld a, $01
    cp b
    jp nz, TestFail

    jp TestSuccess
