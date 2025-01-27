;! MBC_TYPE=2
;! RAM_SIZE=3

INCLUDE "docboy.inc"

; Perform a HDMA (General Purpose) transfer using Cartridge RAM as source.
; Restart the transfer without resetting source address.
; After 8 transfer, the source should be in an illegal area (Echo RAM).

EntryPoint:
    DisablePPU

    ; Enable Cartridge RAM
    ld hl, $0000
    ld a, $0A
    ld [hl], a

    ; Set Cartridge RAM data
    Memset $a000, $ab, $80
    Memcpy $a000, Data, DataEnd - Data

    ; Source address = a000
    ld a, $a0
    ldh [rHDMA1], a

    ld a, $00
    ldh [rHDMA2], a

REPT 9
    Memset $8000, $cd, $80

    ; Dest address = 8000
    ld a, $80
    ldh [rHDMA3], a

    ld a, $00
    ldh [rHDMA4], a

    ; Bit 7 = 0 (general purpose)
    ; Length = 2048 bytes
    ld a, $7f
    ldh [rHDMA5], a
ENDR
    ; --- transfer happens here ---

    ; The transferred data should have a corrupted
    ; byte at the beginning of the first chunk.
    ld hl, $8000
    ld a, [hl]
    cp $ff
    jp z, TestFail

    Memcmp $8001, ExpectedVramData, ExpectedVramDataEnd - ExpectedVramData
    jp nz, TestFail


    jp TestSuccess

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
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
ExpectedVramDataEnd: