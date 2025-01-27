INCLUDE "docboy.inc"

; Check the value of STAT at boot time after first scanline is entered.

EntryPoint:
    ; Wait for first scanline.
    Nops 10

    ; Read STAT
    ldh a, [rSTAT]
    ld b, a

    ; Check result
    ld a, $86
    cp b
    jp nz, TestFail

    jp TestSuccess