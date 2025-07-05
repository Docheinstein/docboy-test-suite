INCLUDE "all.inc"

EntryPoint:
    DisablePPU
    Memset $fe00, $00, 160
    EnablePPU

    ld a, $8f
    ldh [rLYC], a

    Wait 114 * 142

    Nops 104

    ldh a, [rLY]
    cp $8e

    jp nz, TestFail

    jp TestSuccess
