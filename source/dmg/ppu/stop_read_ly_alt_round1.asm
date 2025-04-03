INCLUDE "all.inc"

; STOP with PPU enabled, then read LY for check PPU timing while stopped.

EntryPoint:
    DisablePPU
    EnablePPU

    ; Go to line 20
    LongWait 20 * 114 + 64

    stop

    Nops 106

    ; Read STAT
    ldh a, [rLY]
    cp $00

    jp nz, TestFail
    jp TestSuccess