INCLUDE "all.inc"

; Check the timing of STAT with various SCX.

EntryPoint:
    DisablePPU

    ; Set SCX=1
    ld a, $01
    ldh [rSCX], a

    EnablePPU

    Nops 114

    Nops 59

    ; Read STAT
    ldh a, [rSTAT]
    cp $83

    jp nz, TestFail
    jp TestSuccess

