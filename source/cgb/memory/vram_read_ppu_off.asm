INCLUDE "docboy.inc"

; Reading from VRAM with PPU off should read data correctly.

EntryPoint:
    DisablePPU

    ; Write something to VRAM
    ld a, $12
    ld hl, $8000
    ld [hl], a

    ; Read back from VRAM
    ld a, [hl]
    cp $12

    jp nz, TestFail
    jp TestSuccess
