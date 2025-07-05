INCLUDE "all.inc"

; STOP with PPU enabled, then read LY for check PPU timing while stopped.

EntryPoint:
    DisablePPU
    EnablePPU

    ; Go to line 20
    Wait 20 * 114

    stop

    Nops 170

    ; Read STAT
    ldh a, [rLY]
    cp $00

    jp nz, TestFail
    jp TestSuccess