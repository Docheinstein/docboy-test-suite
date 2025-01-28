INCLUDE "all.inc"

EntryPoint:
    DisablePPU
    Memset $fe00, $00, 160
    EnablePPU

    ld a, $90
    ldh [rLYC], a

    LongWait 114 * 143

    Nops 104

    ldh a, [rLY]
    cp $8f

    jp nz, TestFail

    jp TestSuccess
