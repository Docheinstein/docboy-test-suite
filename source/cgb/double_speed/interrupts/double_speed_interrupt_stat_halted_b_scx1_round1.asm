INCLUDE "all.inc"

; Check the timing of stat interrupt in double speed mode with a certain SCX while halted.

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

    ; Enable STAT interrupt
    ld a, IEF_STAT
    ldh [rIE], a

    ; Enable HBlank interrupt
    ld a, STATF_MODE00
    ldh [rSTAT], a

    ; Reset DIV
    ldh [rDIV], a

    ; Enable interrupt
    ei

    ; Halt
    halt
    nop

    ; We should not reach this point
    jp TestFail

TestFinish:
    Nops 2

    ldh a, [rDIV]
    cp $01

    jp nz, TestFail

    jp TestSuccess


SECTION "STAT handler", ROM0[$48]
    jp TestFinish
