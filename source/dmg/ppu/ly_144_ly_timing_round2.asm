INCLUDE "docboy.inc"

EntryPoint:
    DisablePPU
    Memset $fe00, $00, 160
    EnablePPU

    ld a, $90
    ldh [rLYC], a

    LongWait 114 * 143

    Nops 105

    ldh a, [rLY]
    cp $90

    jp nz, TestFail

    jp TestSuccess
