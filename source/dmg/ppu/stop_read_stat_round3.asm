INCLUDE "all.inc"

; STOP with PPU enabled, then read STAT for check PPU timing while stopped.

EntryPoint:
    DisablePPU
    EnablePPU

    ; Go to line 20
    LongWait 20 * 114

    stop

    Nops 58

    ; Read STAT
    ldh a, [rSTAT]
    cp $86

    jp nz, TestFail
    jp TestSuccess