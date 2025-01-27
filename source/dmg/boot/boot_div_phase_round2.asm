INCLUDE "docboy.inc"

; Check the phase of DIV at boot time.

EntryPoint:
    ; 6 nops should read DIV=AC
    Nops 6

    ; Load DIV
    ldh a, [rDIV]
    ld b, a

    ; Check result
    ld a, $ac
    cp b
    jp nz, TestFail

    jp TestSuccess