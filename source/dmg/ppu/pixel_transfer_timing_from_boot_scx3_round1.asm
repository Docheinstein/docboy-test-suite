INCLUDE "all.inc"

; Check the duration of Pixel Transfer with a certain SCX coming from boot.

EntryPoint:
    ; Load SCX=3
    ld a, $03
    ldh [rSCX], a

    ; 65 nops should read PIXEL TRANSFER.
    Nops 65

    ; Check result
    ldh a, [rSTAT]
    ld b, a
    ld a, $87
    cp b
    jp nz, TestFail

    jp TestSuccess