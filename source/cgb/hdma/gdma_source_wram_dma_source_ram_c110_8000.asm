CartridgeType $02
RamSize $03

INCLUDE "all.inc"

; Check what happens when both HDMA and DMA run together.
;
; DMA source  : RAM   (a000) [ext bus]
; DMA dest    : OAM   (fe00) [oam bus]
; DMA routine : HRAM  (ff80) [cpu bus]
; HDMA source : WRAM1 (c110) [wram bus]
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
    Memset $c110, $34, 160

    ; Reset HDMA destination
    Memset $8000, $cd, 160

    ; Set HDMA source address
    ld a, $C1
    ldh [rHDMA1], a

    ld a, $10
    ldh [rHDMA2], a

    ; Set HDMA destination address
    ld a, $80
    ldh [rHDMA3], a

    ld a, $00
    ldh [rHDMA4], a

    ; Copy the DMA transfer routine
    Memcpy $ff80, DmaTransferRoutine, DmaTransferRoutineEnd - DmaTransferRoutine

    ; Jump to DMA transfer routine
    call $ff80

    DisablePPU

    Memcmp $8000, ExpectedHdmaData, ExpectedHdmaDataEnd - ExpectedHdmaData
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
    db $34, $34, $34, $34, $34, $34, $34, $34
    db $34, $34, $34, $34, $34, $34, $34, $34
    db $34, $34, $34, $34, $34, $34, $34, $34
    db $34, $34, $34, $34, $34, $34, $34, $34
    db $34, $34, $34, $34, $34, $34, $34, $34
    db $34, $34, $34, $34, $34, $34, $34, $34
    db $34, $34, $34, $34, $34, $34, $34, $34
    db $34, $34, $34, $34, $34, $34, $34, $34
    db $cd, $cd, $cd, $cd, $cd, $cd, $cd, $cd
    db $cd, $cd, $cd, $cd, $cd, $cd, $cd, $cd
    db $cd, $cd, $cd, $cd, $cd, $cd, $cd, $cd
    db $cd, $cd, $cd, $cd, $cd, $cd, $cd, $cd
    db $cd, $cd, $cd, $cd, $cd, $cd, $cd, $cd
    db $cd, $cd, $cd, $cd, $cd, $cd, $cd, $cd
    db $cd, $cd, $cd, $cd, $cd, $cd, $cd, $cd
    db $cd, $cd, $cd, $cd, $cd, $cd, $cd, $cd
ExpectedHdmaDataEnd:

ExpectedDmaData:
    db $12, $12, $12, $12, $12, $ab, $ab, $ab
    db $ab, $ab, $ab, $ab, $ab, $ab, $ab, $ab
    db $ab, $34, $ab, $34, $ab, $34, $ab, $34
    db $ab, $34, $ab, $34, $ab, $34, $ab, $34
    db $ab, $34, $ab, $34, $ab, $12, $12, $12
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