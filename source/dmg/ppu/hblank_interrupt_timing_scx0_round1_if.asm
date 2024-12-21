INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "print.inc"
INCLUDE "debug.inc"

EntryPoint:
    Nops 123

    ld a, 3
    ldh [rSCX], a

    ld hl, rIF

    ld a, STATF_MODE00
    ldh [rSTAT], a

    ld a, IEF_STAT
    ldh [rIE], a

    xor a
    ldh [rIF], a

    ei
    xor a

    ldh [rDIV], a

    Nops 36

    ld a, [hl]
    di

    jp TestFail

TestContinue:
    DumpRegisters


SECTION "STAT handler", ROM0[$48]
    jp TestContinue
