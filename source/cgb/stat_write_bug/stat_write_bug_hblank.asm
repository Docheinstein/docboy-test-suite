INCLUDE "all.inc"

; STAT write bug does not happen for CGB.

EntryPoint:
    DisablePPU

    ; Write SCX=0
    ld a, $00
    ldh [rSCX], a

    EnablePPU

    LongWait 114

    xor a
    ldh [rIF], a

    Nops 60

    ldh [rSTAT], a

    ldh a, [rIF]
    cp $e0

    jp nz, TestFail

    jp TestSuccess
