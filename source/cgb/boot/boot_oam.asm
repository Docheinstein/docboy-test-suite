INCLUDE "all.inc"

; Check the content of OAM at boot time.
; It should be zero-initialized.

EntryPoint:
    DisablePPU

    Memtest $FE00, $00, 160

    jp nz, TestFail
    jp TestSuccess

