INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Check how much time it takes to read HBLANK mode from STAT with a certain SCX.

EntryPoint:
    ; Load SCX=3
    ld a, $03
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