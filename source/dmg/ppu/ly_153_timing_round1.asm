INCLUDE "all.inc"

; Check precise timing of LY for last scanline.
; LY should be proceed as 152 -> 153 -> 0 in three M-cycles.

EntryPoint:
    ; Reset PPU
    DisablePPU
    EnablePPU

    LongWait 152 * 114 + 109

    ; Read LY: it should read 152
    ldh a, [rLY]
    cp $98
    jp nz, TestFail
    jp TestSuccess
