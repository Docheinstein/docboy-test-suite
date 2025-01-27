;! MBC_TYPE=2
;! RAM_SIZE=3

INCLUDE "docboy.inc"

; Check what happens when both HDMA and DMA run together.
;
; DMA source  : RAM   (a000) [ext bus]
; DMA dest    : OAM   (fe00) [oam bus]
; DMA routine : HRAM  (ff80) [cpu bus]
; HDMA source : WRAM1 (c000) [wram bus]
; HDMA dest   : VRAM  (8000) [vram bus]

EntryPoint:
    DisableAPU
    DisablePPU

    ; Enable Cartridge RAM
    ld hl, $0000
    ld a, $0A
    ld [hl], a

    ; Set DMA source data
    Memset $a000, $12, 160

    ; Reset DMA destination
    Memset $fe00, $ab, 160

    ; Set HDMA source data
    Memset $c000, $34, 160

    ; Reset HDMA destination
    Memset $8000, $cd, 160

    ; Set HDMA source address
    ld a, $C0
    ldh [rHDMA1], a

    ld a, $00
    ldh [rHDMA2], a

    ; Set HDMA destination address
    ld a, $80
    ldh [rHDMA3], a

    ld a, $00
    ldh [rHDMA4], a

    ; Copy the DMA transfer routine
    Memcpy $ff80, DmaTransferRoutine, DmaTransferRoutineEnd - DmaTransferRoutine

    ; After 4 transfer, the source should be in an illegal area (Echo RAM)
REPT 4
    ; Bit 7 = 0 (general purpose)
    ; Length = 2048 bytes
    ld a, $7f
    ldh [rHDMA5], a
ENDR

    ; Jump to DMA transfer routine
    call $ff80

    DisablePPU

    ; The transferred data should have a corrupted
    ; byte at the beginning of the first chunk.
    ld hl, $8000
    ld a, [hl]
    cp $ff
    jp z, TestFail

    Memcmp $8001, ExpectedHdmaData, ExpectedHdmaDataEnd - ExpectedHdmaData
    jp nz, TestFail

    Memcmp $fe00, ExpectedDmaData, ExpectedDmaDataEnd - ExpectedDmaData
    jp nz, TestFail

    jp TestSuccess


DmaTransferRoutine:
    ; Start DMA
    ld a, $a0
    ldh [rDMA], a

    ; Start HDMA
    ; Bit 7 = 0 (general purpose)
    ; Length = 64 bytes / $10 - 1 => 3
    ld a, $03
    ldh [rHDMA5], a

    ; Wait until the end of DMA
    ld a, 40
.dmaloop
    dec a
    jr nz, .dmaloop

    ret
DmaTransferRoutineEnd:

ExpectedHdmaData:
    db      $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $34, $34, $34, $34, $34, $34, $34, $34
    db $34, $34, $34, $34, $34, $34, $34, $34
    db $34, $34, $34, $34, $34, $34, $34, $34
    db $34, $34, $34, $34, $34, $34, $34, $34
    db $34, $34, $34, $34, $34, $34, $34, $34
    db $34, $34, $34, $34, $34, $34, $34, $34
    db $34, $34, $34, $34, $34, $34, $34, $34
    db $34, $34, $34, $34, $34, $34, $34, $34
ExpectedHdmaDataEnd:

ExpectedDmaData:
    db $12, $ff, $12, $ff, $12, $ff, $ab, $ff
    db $ab, $ff, $ab, $ff, $ab, $ff, $ab, $ff
    db $ab, $ff, $ab, $ff, $ab, $ff, $ab, $ff
    db $ab, $ff, $ab, $ff, $ab, $ff, $ab, $ff
    db $ab, $ff, $ab, $ff, $ab, $12, $12, $12
    db $12, $12, $12, $12, $12, $12, $12, $12
    db $12, $12, $12, $12, $12, $12, $12, $12
    db $12, $12, $12, $12, $12, $12, $12, $12
    db $12, $12, $12, $12, $12, $12, $12, $12
    db $12, $12, $12, $12, $12, $12, $12, $12
    db $12, $12, $12, $12, $12, $12, $12, $12
    db $12, $12, $12, $12, $12, $12, $12, $12
    db $12, $12, $12, $12, $12, $12, $12, $12
    db $12, $12, $12, $12, $12, $12, $12, $12
    db $12, $12, $12, $12, $12, $12, $12, $12
    db $12, $12, $12, $12, $12, $12, $12, $12
ExpectedDmaDataEnd: