INCLUDE "all.inc"

; Check timing of LY for line 143.

EntryPoint:
    DisablePPU
    EnablePPU

    ld a, $8f
    ldh [rLYC], a

    LongWait 114 * 142

    Nops 104

    ldh a, [rLY]
    cp $8e

    jp nz, TestFail
    jp TestSuccess
