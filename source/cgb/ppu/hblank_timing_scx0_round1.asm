INCLUDE "all.inc"

; Check the timing of STAT with various SCX.

EntryPoint:
    DisablePPU

    ; Set SCX=0
    ld a, $00
    ldh [rSCX], a

    EnablePPU

    Wait 114

    Wait 59

    ; Read STAT
    ldh a, [rSTAT]
    cp $83

    jp nz, TestFail
    jp TestSuccess

