INCLUDE "all.inc"

; Check the timing of STAT's interrupt while halted with different SCXs with HBlank interrupt enabled.

EntryPoint:
    Nops 123

    ld a, $02
    ldh [rSCX], a

    ld a, STATF_MODE00
    ldh [rSTAT], a

    ld a, IEF_STAT
    ldh [rIE], a

    xor a
    ldh [rIF], a

    ei

    ; Reset DIV
    xor a
    ldh [rDIV], a

    ; Reset TIMA
    ldh [rTIMA], a

    ; Enable timer at 262KHZ Hz
    ld a, TACF_START | TACF_262KHZ
    ldh [rTAC], a

    halt

TestContinue:
    Nops 3

    ldh a, [rTIMA]

    cp $0c

    jp nz, TestFail

    jp TestSuccess


SECTION "STAT handler", ROM0[$48]
    jp TestContinue

