INCLUDE "all.inc"

; Check precise timing of LY for last scanline.

EntryPoint:
    DisablePPU
    EnablePPU

    Wait 152 * 114 + 111

    ; Read LY: it should read 0
    ldh a, [rLY]
    cp $99
    jp nz, TestFail
    jp TestSuccess
