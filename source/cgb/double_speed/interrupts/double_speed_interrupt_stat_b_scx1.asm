INCLUDE "all.inc"

; Check the timing of stat interrupt in double speed mode with a certain SCX.

EntryPoint:
    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Change speed
    stop

    ; Reset PPU
    DisablePPU

    ; Set SCX=1
    ld a, $01
    ldh [rSCX], a

    EnablePPU

    Wait 2 * 114 * 2

    Nops 1

    ; Enable STAT interrupt
    ld a, IEF_STAT
    ldh [rIE], a

    ; Enable HBlank interrupt
    ld a, STATF_MODE00
    ldh [rSTAT], a

    ; Enable interrupt
    ei

    xor a

REPT 200
    inc a
ENDR

    ; We should not reach this point
    jp TestFail

TestFinish:
    cp $70
    jp nz, TestFail

    jp TestSuccess


SECTION "STAT handler", ROM0[$48]
    jp TestFinish
