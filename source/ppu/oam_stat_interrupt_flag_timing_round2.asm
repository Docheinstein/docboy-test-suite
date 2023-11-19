INCLUDE "hardware.inc"
INCLUDE "common.inc"

; STAT interrupt with OAM mode should be triggered at dot 454.

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

    ; 107 nops should be enough for IF to be set
    Nops 107

    ; Read IF
    ldh a, [rIF]
    ld b, a

    ; Check result
    ld a, $e2
    cp b
    jp nz, TestFail

    jp TestSuccess
