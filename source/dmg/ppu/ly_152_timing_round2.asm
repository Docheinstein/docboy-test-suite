INCLUDE "all.inc"

; Check precise timing of LY for LY 152.

EntryPoint:
    ; Reset PPU
    DisablePPU
    EnablePPU

    LongWait 151 * 114 + 110

    ; Read LY: it should read 152
    ldh a, [rLY]
    cp $98

    jp nz, TestFail
    jp TestSuccess
