INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Check how much time it takes for DIV to increase by 1 after a reset.

EntryPoint:
    ; Reset DIV
    ldh [rDIV], a

    ; 60 nops should read DIV=0
    Nops 60

    ; Load DIV
    ldh a, [rDIV]
    ld b, a

    ; Check result
    xor a
    cp b
    jp nz, TestFail

    jp TestSuccess