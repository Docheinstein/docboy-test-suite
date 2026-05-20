INCLUDE "all.inc"

; STOP with PPU enabled, then read LY for check PPU timing while stopped.

EntryPoint:
    DisablePPU
    EnablePPU

    ; Go to line 30
    Wait 30 * 114 + 64

    stop

    Wait 107

    ; Read STAT
    ldh a, [rLY]
    cp $0b

    jp nz, TestFail
    jp TestSuccess