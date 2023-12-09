INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Check how much time it takes to read HBLANK mode from STAT with a certain SCX.

EntryPoint:
    ; Load SCX=4
    ld a, $04
    ldh [rSCX], a

    ; 67 nops should read HBLANK.
    Nops 67

    ; Check result
    ldh a, [rSTAT]
    ld b, a
    ld a, $84
    cp b
    jp nz, TestFail

    jp TestSuccess