INCLUDE "docboy.inc"

; Perform a basic HDMA (General Purpose) transfer.
; Check that the last four bits of HDMA4 are ignored.

EntryPoint:
    DisablePPU

    ; Copy data to WRAM2
    Memcpy $D000, VramData, VramDataEnd - VramData

    ; Put some data at VRAM
    Memset $8400, $f0, $80

    ; Source address = D000
    ld a, $D0
    ldh [rHDMA1], a

    ld a, $00
    ldh [rHDMA2], a

    ; Dest address = 8400
    ld a, $04 ; the first three bits are ignored
    ldh [rHDMA3], a

    ld a, $0F ; the last four bits are ignored
    ldh [rHDMA4], a

    ; Bit 7 = 0 (general purpose)
    ; Length = 64 bytes / $10 - 1 => 3
    ld a, $03
    ldh [rHDMA5], a

    ; --- transfer happens here ---

    Memcmp $8400, VramData, VramDataEnd2 - VramData
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