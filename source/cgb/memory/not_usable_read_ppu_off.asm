INCLUDE "all.inc"

; Reading from Not Usable area with PPU off should should read data correctly.

EntryPoint:
    DisablePPU

    ; Write something to Not Usable
    ld a, $12
    ld hl, $fea0
    ld [hl], a

    ; Read back from Not Usable
    ld a, [hl]
    cp $12

    jp nz, TestFail
    jp TestSuccess
