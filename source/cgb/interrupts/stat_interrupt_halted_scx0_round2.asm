INCLUDE "all.inc"

; Check the timing of STAT interrupt while halted.

EntryPoint:
    ; Reset DIV
    xor a
    ldh [rDIV], a

    DisablePPU

    ; Set SCX=0
    ld a, $00
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

    halt

    Nops 62
    ldh a, [rDIV]
    cp $04

    jp nz, TestFail
    jp TestSuccess
