INCLUDE "all.inc"

; Reset IF when mode is entering OAM.

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

    Nops 106

    xor a
    ldh [rIF], a

    ; Read IF
    ldh a, [rIF]
    cp $e0

    jp nz, TestFail

    jp TestSuccess
