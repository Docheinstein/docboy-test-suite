INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Check how much time it takes to read HBLANK mode from STAT with a certain SCX.

EntryPoint:
    ; Load SCX=2
    ld a, $02
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