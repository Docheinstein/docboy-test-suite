INCLUDE "docboy.inc"

; Perform a HDMA (General Purpose) transfer using end of WRAM2 as source.
; HDMA should read real data until cursor is within WRAM2,
; then it should correctly read FF from when cursor is outside a valid address range.

EntryPoint:
    DisablePPU

    ; Set WRAM1 data
    Memset $C000, $ab, $80

    ; Set VRAM data
    Memset $8000, $cd, $80

    ; Set WRAM2 data
    Memcpy $DFE0, Data, DataEnd - Data

    ; Source address = dfe0
    ld a, $df
    ldh [rHDMA1], a

    ld a, $e0
    ldh [rHDMA2], a

    ; Dest address = 8000
    ld a, $80
    ldh [rHDMA3], a

    ld a, $00
    ldh [rHDMA4], a

    ; Bit 7 = 0 (general purpose)
    ; Length = 80 bytes / $10 - 1 => 4
    ld a, $04
    ldh [rHDMA5], a

    ; --- transfer happens here ---

    DisablePPU

    ; The transferred data shouldn't have a corrupted
    ; byte at the beginning of the first chunk since we
    ; were reading from wram bus, not ext bus.

    Memcmp $8000, ExpectedVramData, ExpectedVramDataEnd - ExpectedVramData
    jp nz, TestFail

    jp TestSuccess

Data:
    db $00, $11, $22, $33, $44, $55, $66, $77
    db $88, $99, $aa, $bb, $cc, $dd, $ee, $ff
    db $11, $22, $33, $44, $55, $66, $77, $88
    db $99, $aa, $bb, $cc, $dd, $ee, $ff, $00
DataEnd:

ExpectedVramData:
    db $00, $11, $22, $33, $44, $55, $66, $77
    db $88, $99, $aa, $bb, $cc, $dd, $ee, $ff
    db $11, $22, $33, $44, $55, $66, $77, $88
    db $99, $aa, $bb, $cc, $dd, $ee, $ff, $00
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $cd, $cd, $cd, $cd, $cd, $cd, $cd, $cd
    db $cd, $cd, $cd, $cd, $cd, $cd, $cd, $cd
ExpectedVramDataEnd: