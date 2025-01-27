INCLUDE "docboy.inc"

; Check precise timing of LY for LY 152.

EntryPoint:
    ; Reset PPU
    DisablePPU
    EnablePPU

    LongWait 151 * 114 + 109

    ; Read LY: it should read 151
    ldh a, [rLY]
    cp $97

    jp nz, TestFail
    jp TestSuccess
