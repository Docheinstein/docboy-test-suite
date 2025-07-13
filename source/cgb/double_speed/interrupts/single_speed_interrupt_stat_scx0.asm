INCLUDE "all.inc"

; Check the timing of STAT interrupt with a certain SCX
; in single speed (after a switch back from double speed).

EntryPoint:
    DisablePPU
    DisableAPU

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

    ; Switch to single speed
    stop

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

    ei

    xor a
REPT 256
    inc a
ENDR

    jp TestFail

TestContinue:
    cp $2e

    jp nz, TestFail
    jp TestSuccess


SECTION "STAT handler", ROM0[$48]
    jp TestContinue
