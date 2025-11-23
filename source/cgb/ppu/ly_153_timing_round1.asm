INCLUDE "all.inc"

; Check precise timing of LY for last scanline.

EntryPoint:
    ; Reset PPU
    DisablePPU
    EnablePPU

    Wait 152 * 114 + 109

    ; Read LY: it should read 152
    ldh a, [rLY]
    cp $98
    jp nz, TestFail
    jp TestSuccess
