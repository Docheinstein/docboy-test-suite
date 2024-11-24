INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "cgb.inc"

; Perform a HDMA (General Purpose) transfer using fea0 as source.
; HDMA should read FF instead of real data.
; The first read block should be a corrupted byte.

EntryPoint:
    DisablePPU

    ; Set VRAM data
    Memset $8000, $cd, $80

    Memcpy $fea0, Data, DataEnd - Data

    ; Source address = fea0
    ld a, $fe
    ldh [rHDMA1], a

    ld a, $a0
    ldh [rHDMA2], a

    ; Dest address = 8000
    ld a, $80
    ldh [rHDMA3], a

    ld a, $00
    ldh [rHDMA4], a

    ; Bit 7 = 0 (general purpose)
    ; Length = 64 bytes / $10 - 1 => 3
    ld a, $03
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
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $cd, $cd, $cd, $cd, $cd, $cd, $cd, $cd
    db $cd, $cd, $cd, $cd, $cd, $cd, $cd, $cd
ExpectedVramDataEnd: