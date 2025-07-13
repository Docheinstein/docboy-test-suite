INCLUDE "all.inc"

; Check the timing of VBlank interrupt
; in single speed (after a switch back from double speed).

EntryPoint:
    DisablePPU
    EnablePPU

    ; Reset DIV
    xor a
    ldh [rDIV], a

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Switch to double speed
    stop

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    Nops 1

    ; Switch to single speed
    stop

    ; Skip some lines
    Nops 20 * 114

    ; Reset IF
    xor a
    ldh [rIF], a

    ; Enable VBLANK interrupt
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
