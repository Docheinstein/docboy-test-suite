INCLUDE "all.inc"

; Check the timing of STAT interrupt during speed switch to single speed.

EntryPoint:
    ; Reset DIV
    xor a
    ldh [rDIV], a

    DisablePPU

    ; Set SCX=0
    ld a, $00
    ldh [rSCX], a

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    stop

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    Nops 1

    ; Switch to double speed
    stop

    ; Enable interrupt
    ei

    EnablePPU

    ; Skip some lines
    Nops 114 * 142

    ; Reset IF
    xor a
    ldh [rIF], a

    ; Enable VBLANK interrupt
    ld a, IEF_VBLANK
    ldh [rIE], a
    ldh [rIF], a

REPT 256
    inc a
ENDR

    jp TestFail

TestContinue:
    cp $01

    jp nz, TestFail
    jp TestSuccess

SECTION "VBlank handler", ROM0[$40]
    jp TestContinue
