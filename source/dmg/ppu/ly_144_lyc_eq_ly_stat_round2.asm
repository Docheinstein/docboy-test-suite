INCLUDE "all.inc"

EntryPoint:
    DisablePPU
    Memset $fe00, $00, 160
    EnablePPU

    ld a, $90
    ldh [rLYC], a

    LongWait 114 * 143

    Nops 106

    ldh a, [rSTAT]
    cp $85

    jp nz, TestFail

    jp TestSuccess