INCLUDE "all.inc"

; Check the timing of STAT with various SCX.

EntryPoint:
    DisablePPU

    ; Set SCX=2
    ld a, $02
    ldh [rSCX], a

    EnablePPU

    Nops 114

    Nops 60

    ; Read STAT
    ldh a, [rSTAT]
    cp $80

    jp nz, TestFail
    jp TestSuccess

