INCLUDE "all.inc"

; Check the timing of STAT with various SCX.

EntryPoint:
    DisablePPU

    ; Set SCX=3
    ld a, $03
    ldh [rSCX], a

    EnablePPU

    Wait 114

    Wait 60

    ; Read STAT
    ldh a, [rSTAT]
    cp $80

    jp nz, TestFail
    jp TestSuccess

