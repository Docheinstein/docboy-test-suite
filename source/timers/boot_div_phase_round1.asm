INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Check the phase of DIV at boot time.

EntryPoint:
    ; 5 nops should read DIV=AB
    Nops 5

    ; Load DIV
    ldh a, [rDIV]
    ld b, a

    ; Check result
    ld a, $ab
    cp b
    jp nz, TestFail

    jp TestSuccess