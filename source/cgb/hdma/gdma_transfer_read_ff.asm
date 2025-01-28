INCLUDE "all.inc"

; Perform a basic HDMA (General Purpose) transfer.
; Check that we read FF instantly (transfer completed)

EntryPoint:
    DisablePPU

    ; Copy data to WRAM2
    Memcpy $D000, VramData, VramDataEnd - VramData

    ; Put some data at VRAM
    Memset $8000, $f0, $80

    ; Source address = D000
    ld a, $D0
    ldh [rHDMA1], a

    ld a, $00
    ldh [rHDMA2], a

    ; Dest address = 8000
    ld a, $80
    ldh [rHDMA3], a

    ld a, $00
    ldh [rHDMA4], a

    ; Bit 7 = 0 (general purpose)
    ; Length = 640 bytes / $10 - 1 => 39 = $27
    ld a, $27
    ldh [rHDMA5], a

    ; --- transfer happens here ---

    ldh a, [rHDMA5]

    cp $ff
    jp nz, TestFail

    jp TestSuccess

VramData:
    db $00, $11, $22, $33, $44, $55, $66, $77
    db $88, $99, $aa, $bb, $cc, $dd, $ee, $ff
    db $11, $22, $33, $44, $55, $66, $77, $88
    db $99, $aa, $bb, $cc, $dd, $ee, $ff, $00
    db $22, $33, $44, $55, $66, $77, $88, $99
    db $aa, $bb, $cc, $dd, $ee, $ff, $00, $11
    db $33, $44, $55, $66, $77, $88, $99, $aa
    db $bb, $cc, $dd, $ee, $ff, $00, $11, $22
VramDataEnd:
    db $f0, $f0, $f0, $f0, $f0, $f0, $f0, $f0
    db $f0, $f0, $f0, $f0, $f0, $f0, $f0, $f0
    db $f0, $f0, $f0, $f0, $f0, $f0, $f0, $f0
    db $f0, $f0, $f0, $f0, $f0, $f0, $f0, $f0
    db $f0, $f0, $f0, $f0, $f0, $f0, $f0, $f0
    db $f0, $f0, $f0, $f0, $f0, $f0, $f0, $f0
    db $f0, $f0, $f0, $f0, $f0, $f0, $f0, $f0
    db $f0, $f0, $f0, $f0, $f0, $f0, $f0, $f0
VramDataEnd2: