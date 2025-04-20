INCLUDE "all.inc"

; Check the timing of VBlank interrupt while halted if interrupt is set manually before EI.

EntryPoint:
    ; Reset DIV
    xor a
    ldh [rDIV], a

    DisablePPU

    ; Reset interrupts
    xor a
    ldh [rIE], a
    ldh [rIF], a

    ; Set SCX=0
    ld a, $00
    ldh [rSCX], a

    EnablePPU

    ; Skip some lines
    Nops 114 * 142

    ; Reset IF
    xor a
    ldh [rIF], a

    ; Enable TIMER interrupt
    ld a, IEF_VBLANK
    ldh [rIE], a
    ldh [rIF], a

    ; Enable interrupt
    ei

REPT 256
    inc a
ENDR

    jp TestFail

TestContinue:
    cp $02

    jp nz, TestFail
    jp TestSuccess

SECTION "VBlank handler", ROM0[$40]
    jp TestContinue

