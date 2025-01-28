INCLUDE "all.inc"

; STAT mode should be set to OAM at dot 0.

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

    ; 108 nops should be enough for read OAM mode from STAT
    Nops 108

    ; Read IF
    ldh a, [rSTAT]
    ld b, a

    ; Check result
    ld a, $a2
    cp b
    jp nz, TestFail

    jp TestSuccess
