INCLUDE "all.inc"

; STAT write bug does not happen even in DMG mode.

EntryPoint:
    DisablePPU

    ; Write SCX=0
    ld a, $00
    ldh [rSCX], a

    EnablePPU

    Wait 114

    xor a
    ldh [rIF], a

    Nops 60

    ldh [rSTAT], a

    ldh a, [rIF]
    cp $e0

    jp nz, TestFail

    jp TestSuccess
