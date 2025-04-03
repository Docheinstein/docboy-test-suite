INCLUDE "all.inc"

; STOP with PPU enabled, then read LY for check PPU timing while stopped.

EntryPoint:
    DisablePPU
    EnablePPU

    ; Go to line 20
    LongWait 20 * 114

    stop

    Nops 171

    ; Read STAT
    ldh a, [rLY]
    cp $01

    jp nz, TestFail
    jp TestSuccess