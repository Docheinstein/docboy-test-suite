INCLUDE "all.inc"

; Check precise timing of LY for last scanline.

EntryPoint:
    ; Reset PPU
    DisablePPU
    EnablePPU

    Wait 152 * 114 + 110

    ; Read LY: it should read 153
    ldh a, [rLY]
    cp $99
    jp nz, TestFail
    jp TestSuccess
