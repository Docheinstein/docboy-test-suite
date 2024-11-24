INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "cgb.inc"

; Perform a HDMA (General Purpose) transfer using VRAM as source.
; HDMA should read FF instead of real data.
; The first read block should be a corrupted byte.

EntryPoint:
    DisablePPU

    ; Set VRAM data
    Memset $8000, $ab, $80
    Memset $8400, $cd, $80

    Memcpy $8000, VramData, VramDataEnd - VramData

    ; Source address = 8000
    ld a, $80
    ldh [rHDMA1], a

    ld a, $00
    ldh [rHDMA2], a

    ; Dest address = 8400
    ld a, $84
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
    ld hl, $8400
    ld a, [hl]
    cp $ff
    jp z, TestFailCGB

    Memcmp $8401, ExpectedVramData, ExpectedVramDataEnd - ExpectedVramData
    jp nz, TestFailCGB

    jp TestSuccessCGB

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