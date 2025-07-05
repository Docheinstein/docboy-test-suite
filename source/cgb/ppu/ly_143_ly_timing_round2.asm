INCLUDE "all.inc"

; Check timing of LY for line 143.

EntryPoint:
    DisablePPU
    EnablePPU

    ld a, $8f
    ldh [rLYC], a

    Wait 114 * 142

    Nops 105

    ldh a, [rLY]
    cp $8f

    jp nz, TestFail
    jp TestSuccess
