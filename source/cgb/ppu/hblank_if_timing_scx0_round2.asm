INCLUDE "all.inc"

; Check when IF for STAT HBlank is triggered with various SCX.

EntryPoint:
    DisablePPU

    ; Enable STAT (HBlank) interrupt
    ld a, IEF_STAT
    ldh [rIE], a

    ld a, STATF_MODE00
    ldh [rSTAT], a

    ; Set SCX=0
    ld a, $00
    ldh [rSCX], a

    EnablePPU

    Nops 114

    ; Reset IF
    xor a
    ldh [rIF], a

    Nops 56

    ; Read IF
    ldh a, [rIF]
    cp $e2

    jp nz, TestFail
    jp TestSuccess

