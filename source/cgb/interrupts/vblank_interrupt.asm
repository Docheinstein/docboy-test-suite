INCLUDE "all.inc"

; Check the timing of Vblank interrupt.

EntryPoint:
    ; Reset DIV
    xor a
    ldh [rDIV], a

    DisablePPU

    ; Set SCX=0
    ld a, $00
    ldh [rSCX], a

    EnablePPU

    ; Skip some lines
    Nops 114 * 142

    ; Reset IF
    xor a
    ldh [rIF], a

    ; Enable VBlank interrupt
    ld a, IEF_VBLANK
    ldh [rIE], a

    ei

    xor a
REPT 256
    inc a
ENDR

    jp TestFail

TestContinue:
    cp $d8

    jp nz, TestFail
    jp TestSuccess

SECTION "VBlank handler", ROM0[$40]
    jp TestContinue

