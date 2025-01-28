INCLUDE "all.inc"

; Check the duration of Pixel Transfer with a certain SCX coming from boot.

EntryPoint:
    ; Load SCX=4
    ld a, $04
    ldh [rSCX], a

    ; 66 nops should read PIXEL TRANSFER.
    Nops 66

    ; Check result
    ldh a, [rSTAT]
    ld b, a
    ld a, $87
    cp b
    jp nz, TestFail

    jp TestSuccess