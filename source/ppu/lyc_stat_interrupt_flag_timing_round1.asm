INCLUDE "hardware.inc"
INCLUDE "common.inc"

; STAT interrupt with LYC_EQ_LY should be triggered after 454 t-cycles.

EntryPoint:
    ; Reset IF
    xor a
    ldh [rIF], a

    ; Write LYC=1
    ld a, $01
    ldh [rLYC], a

    ; Enable STAT interrupt
    ld a, IEF_STAT
    ldh [rIE], a

    ; Enable LYC_EQ_LY interrupt
    ld a, STATF_LYC
    ldh [rSTAT], a

    ; 102 nops should not be enough for IF to be set
    Nops 102

    ; Read IF
    ldh a, [rIF]
    ld b, a

    ; Check result
    ld a, $e0
    cp b
    jp nz, TestFail

    jp TestSuccess
