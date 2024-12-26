INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "cgb.inc"

; STAT write bug does not happen for CGB.

EntryPoint:
    DisablePPU

    ; Write SCX=0
    ld a, $00
    ldh [rSCX], a

    ld a, LCDCF_ON | LCDCF_BGON
    ldh [rLCDC], a

    LongWait 114

    xor a
    ldh [rIF], a

    Nops 60

    ldh [rSTAT], a

    ldh a, [rIF]
    cp $e0

    jp nz, TestFailCGB

    jp TestSuccessCGB
