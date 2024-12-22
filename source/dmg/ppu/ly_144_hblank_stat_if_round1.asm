INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "dma.inc"

; Check IF for STAT interrupt for line 144.

EntryPoint:
    DisablePPU
    ResetOAM
    EnablePPU

    LongWait 114 * 143

    ; Wait HBlank
    Nops 70

    ld a, STATF_MODE00
    ldh [rSTAT], a

    ld a, IEF_STAT
    ldh [rIE], a

    xor a
    ldh [rIF], a

    Nops 26

    ldh a, [rIF]
    cp $e0

    jp nz, TestFail

    jp TestSuccess