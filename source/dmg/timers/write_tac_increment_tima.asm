INCLUDE "all.inc"

; Check how much it takes for read IF timer flag set.

EntryPoint:

Round1:
    ; Reset IF
    xor a
    ldh [rIF], a

    ; Reset TIMA
    ldh [rTIMA], a

    ; Reset DIV
    ldh [rDIV], a

    ; Enable timer at 65536 Hz
    ld a, TACF_START | TACF_16KHZ
    ldh [rTAC], a

    ; Wait for DIV[7] to be 1
    Nops 24

    ; Write to TAC
    xor a
    ldh [rTAC], a

    ; Load TIMA
    ldh a, [rTIMA]
    ld b, a

    ; Check that TIMA has been incremented by TAC write
    ld a, $01
    cp b
    jp nz, TestFail

    jp TestSuccess

