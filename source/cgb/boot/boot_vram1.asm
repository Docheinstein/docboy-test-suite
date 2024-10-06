INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "vram.inc"
INCLUDE "dma.inc"
INCLUDE "cgb.inc"

; Check the content of VRAM at boot time.
; It should be zero-initialized.

EntryPoint:
    DisablePPU

    ld a, 1
    ldh [rVBK], a

    ld hl, $8000
    ld de, 8192

.loop:
    ldi a, [hl]
    cp $00
    jp nz, TestFailCGB

    dec de
    ld a, d
    cp $00
    jp nz, .loop
    ld a, e
    jp nz, .loop

    jp TestSuccessCGB

