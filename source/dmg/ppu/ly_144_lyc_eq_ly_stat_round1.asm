INCLUDE "all.inc"

EntryPoint:
    DisablePPU
    Memset $fe00, $00, 160
    EnablePPU

    ld a, $90
    ldh [rLYC], a

    Wait 114 * 143

    Nops 105

    ldh a, [rSTAT]
    cp $80

    jp nz, TestFail

    jp TestSuccess
