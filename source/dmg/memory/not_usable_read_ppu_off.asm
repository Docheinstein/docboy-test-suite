INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Reading from Not Usable area with PPU off should read 00.

EntryPoint:
    DisablePPU

    ; Write something to Not Usable
    ld a, $12
    ld hl, $fea0
    ld [hl], a

    ; Read back from Not Usable
    ld a, [hl]
    cp $00

    jp nz, TestFail
    jp TestSuccess
