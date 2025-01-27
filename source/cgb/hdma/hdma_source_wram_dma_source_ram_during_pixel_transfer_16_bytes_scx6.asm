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

    ; Set SCX=6
    ld a, $06
    ldh [rSCX], a

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

    ; Enable PPU
    EnablePPU

    ; Skip glitched line 0
    ; Go to OAM Scan of line 1
     Nops 126

    ; Jump to DMA transfer routine
    call $ff80

    ; Disable PPU
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
    ; Bit 7 = 1 (HBlank)
    ; Length = 16 bytes / $10 - 1 => 0
    ld a, $80
    ldh [rHDMA5], a

    ; Wait until the end of DMA
    ld a, 255
.dmaloop
    dec a
    jr nz, .dmaloop

    ret
DmaTransferRoutineEnd:

ExpectedHdmaData:
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
    db $cd, $cd, $cd, $cd, $cd, $cd, $cd, $cd
    db $cd, $cd, $cd, $cd, $cd, $cd, $cd, $cd
    db $cd, $cd, $cd, $cd, $cd, $cd, $cd, $cd
    db $cd, $cd, $cd, $cd, $cd, $cd, $cd, $cd
    db $cd, $cd, $cd, $cd, $cd, $cd, $cd, $cd
    db $cd, $cd, $cd, $cd, $cd, $cd, $cd, $cd
ExpectedHdmaDataEnd:

ExpectedDmaData:
    db $12, $34, $12, $34, $12, $34, $12, $34
    db $12, $34, $12, $34, $12, $34, $12, $34
    db $12, $12, $12, $12, $12, $12, $12, $12
    db $12, $12, $12, $12, $12, $12, $12, $12
    db $12, $12, $12, $12, $12, $12, $12, $12
    db $12, $12, $12, $ab, $ab, $ab, $ab, $ab
    db $ab, $ab, $ab, $12, $12, $12, $12, $12
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