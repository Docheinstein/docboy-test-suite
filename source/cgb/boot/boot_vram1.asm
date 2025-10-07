INCLUDE "all.inc"

; Check the content of VRAM bank 1 at boot time.
; It should be zero-initialized.

EntryPoint:
    DisablePPU

    ld a, 1
    ldh [rVBK], a

    Memtest $8000, $00, 8192

    jp nz, TestFail
    jp TestSuccess

