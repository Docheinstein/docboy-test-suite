INCLUDE "docboy.inc"

EntryPoint:
    DisablePPU
    Memset $fe00, $00, 160
    EnablePPU

    ld a, $8f
    ldh [rLYC], a

    LongWait 114 * 142

    Nops 105

    ldh a, [rSTAT]
    cp $80

    jp nz, TestFail

    jp TestSuccess
