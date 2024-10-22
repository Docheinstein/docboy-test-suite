INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "vram.inc"
INCLUDE "dma.inc"
INCLUDE "cgb.inc"

; Check the content of OAM at boot time.
; It should be zero-initialized.

EntryPoint:
    DisablePPU

    Memtest $FE00, $00, 160

    jp nz, TestFailCGB
    jp TestSuccessCGB

