INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "dma.inc"


EntryPoint:
    DisablePPU
    ResetOAM
    EnablePPU

    ld a, $90
    ldh [rLYC], a

    LongWait 114 * 143

    Nops 105

    ldh a, [rLY]
    cp $90

    jp nz, TestFail

    jp TestSuccess