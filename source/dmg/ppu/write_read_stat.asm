INCLUDE "all.inc"

; Write to STAT then read from it and see the result.

EntryPoint:
    ; Write to STAT
    ld a, STATF_MODE10
    ldh [rSTAT], a

    ; Read from STAT
    ldh a, [rSTAT]
    ld b, a

    ; Check result
    ld a, $a5
    cp b
    jp nz, TestFail

    jp TestSuccess
