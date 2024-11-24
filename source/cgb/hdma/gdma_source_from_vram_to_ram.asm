;! MBC_TYPE=2
;! RAM_SIZE=3

INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "cgb.inc"

; Perform a HDMA (General Purpose) transfer using end of VRAM as source.
; HDMA should read FF instead of real data until cursor is within VRAM,
; then it should correctly read data from RAM when the cursor is within
; a valid address range.
; The first read block should be a corrupted byte.

EntryPoint:
    DisablePPU

    ; Set VRAM data
    Memset $8000, $cd, $80

    ; Enable Cartridge RAM
    ld hl, $0000
    ld a, $0A
    ld [hl], a

    ; Set Cartridge RAM data
    Memcpy $a000, Data, DataEnd - Data

    ; Source address = 9fe0
    ld a, $9f
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

    ; The transferred data should have a corrupted
    ; byte at the beginning of the first chunk.
    ld hl, $8000
    ld a, [hl]
    cp $ff
    jp z, TestFailCGB

    Memcmp $8001, ExpectedVramData, ExpectedVramDataEnd - ExpectedVramData
    jp nz, TestFailCGB

    jp TestSuccessCGB

Data:
    db $00, $11, $22, $33, $44, $55, $66, $77
    db $88, $99, $aa, $bb, $cc, $dd, $ee, $ff
    db $11, $22, $33, $44, $55, $66, $77, $88
    db $99, $aa, $bb, $cc, $dd, $ee, $ff, $00
    db $22, $33, $44, $55, $66, $77, $88, $99
    db $aa, $bb, $cc, $dd, $ee, $ff, $00, $11
    db $33, $44, $55, $66, $77, $88, $99, $aa
    db $bb, $cc, $dd, $ee, $ff, $00, $11, $22
DataEnd:

ExpectedVramData:
    db      $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $00, $11, $22, $33, $44, $55, $66, $77
    db $88, $99, $aa, $bb, $cc, $dd, $ee, $ff
    db $11, $22, $33, $44, $55, $66, $77, $88
    db $99, $aa, $bb, $cc, $dd, $ee, $ff, $00
    db $22, $33, $44, $55, $66, $77, $88, $99
    db $aa, $bb, $cc, $dd, $ee, $ff, $00, $11
    db $cd, $cd, $cd, $cd, $cd, $cd, $cd, $cd
    db $cd, $cd, $cd, $cd, $cd, $cd, $cd, $cd
ExpectedVramDataEnd: