INCLUDE "all.inc"

; Check the timing of STAT interrupt.

EntryPoint:
    ; Reset DIV
    xor a
    ldh [rDIV], a

    DisablePPU

    ; Set SCX=3
    ld a, $03
    ldh [rSCX], a

    EnablePPU

    ; Skip glitched line 0
    Nops 114

    ; Reset IF
    xor a
    ldh [rIF], a

    ; Enable STAT interrupt
    ld a, IEF_STAT
    ldh [rIE], a

    ; Enable HBlank interrupt
    ld a, STATF_MODE00
    ldh [rSTAT], a

    ; Enable interrupts
    ei

    xor a
REPT 256
    inc a
ENDR

    jp TestFail

TestContinue:
    cp $2f

    jp nz, TestFail
    jp TestSuccess


SECTION "STAT handler", ROM0[$48]
    jp TestContinue
