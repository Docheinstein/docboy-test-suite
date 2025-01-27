INCLUDE "docboy.inc"

; Check the duration of Pixel Transfer with a certain SCX coming from boot.

EntryPoint:
    ; Load SCX=1
    ld a, $01
    ldh [rSCX], a

    ; 66 nops should read HBLANK.
    Nops 66

    ; Check result
    ldh a, [rSTAT]
    ld b, a
    ld a, $84
    cp b
    jp nz, TestFail

    jp TestSuccess