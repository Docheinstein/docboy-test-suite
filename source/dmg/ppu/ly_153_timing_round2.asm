INCLUDE "docboy.inc"

; Check precise timing of LY for last scanline.
; LY should be proceed as 152 -> 153 -> 0 in three M-cycles.

EntryPoint:
    ; Reset PPU
    DisablePPU
    EnablePPU

    LongWait 152 * 114 + 110

    ; Read LY: it should read 153
    ldh a, [rLY]
    cp $99
    jp nz, TestFail
    jp TestSuccess
