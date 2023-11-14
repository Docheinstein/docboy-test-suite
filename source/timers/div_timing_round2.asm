INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Check how much time it takes for DIV to increase by 1 after a reset.

EntryPoint:
    ; Reset DIV
    ldh [rDIV], a

    ; 61 nops should read DIV=1
    Nops 61

    ; Load DIV
    ldh a, [rDIV]
    ld b, a

    ; Check result
    ld a, $01
    cp b
    jp nz, TestFail

    jp TestSuccess