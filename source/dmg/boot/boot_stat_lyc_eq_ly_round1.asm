INCLUDE "all.inc"

; Check the value of STAT at boot time.

EntryPoint:
    ; Read STAT
    ldh a, [rSTAT]
    ld b, a

    ; Check result
    ld a, $85
    cp b
    jp nz, TestFail

    jp TestSuccess