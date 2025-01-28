INCLUDE "all.inc"

; Check the timing of STAT's interrupt with OAM interrupt enabled.

EntryPoint:
    Nops 114

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
    cp $e2

    jp nz, TestFail

    jp TestSuccess
