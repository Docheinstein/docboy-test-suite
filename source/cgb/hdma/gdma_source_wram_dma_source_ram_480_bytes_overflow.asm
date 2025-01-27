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

    ; Reset Not Usable
    Memset $fea0, $ef, 96

    ; Set HDMA source data
    Memset $c000 + 0 * 80, $40, 80
    Memset $c000 + 1 * 80, $41, 80
    Memset $c000 + 2 * 80, $42, 80
    Memset $c000 + 3 * 80, $43, 80
    Memset $c000 + 4 * 80, $44, 80
    Memset $c000 + 5 * 80, $45, 80

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

    ; Jump to DMA transfer routine
    call $ff80

    DisablePPU

    Memcmp $fe00, ExpectedDmaData, ExpectedDmaDataEnd - ExpectedDmaData
    jp nz, TestFail

    jp TestSuccess


DmaTransferRoutine:
    ; Start DMA
    ld a, $a0
    ldh [rDMA], a

    ; Start HDMA
    ; Bit 7 = 0 (general purpose)
    ; Length = 480 bytes / $10 - 1 => $1D
    ld a, $1d
    ldh [rHDMA5], a

    ; Wait until the end of DMA
    ld a, 40
.dmaloop
    dec a
    jr nz, .dmaloop

    ret
DmaTransferRoutineEnd:

ExpectedDmaData:
    ; 00
    db $12, $43, $12, $43, $12, $43, $ab, $43
    db $ab, $43, $ab, $43, $ab, $43, $ab, $43
    db $ab, $43, $ab, $43, $ab, $43, $ab, $43
    db $ab, $43, $ab, $43, $ab, $43, $ab, $43

    ; 20
    db $ab, $43, $ab, $43, $ab, $43, $ab, $43
    db $ab, $43, $ab, $43, $ab, $43, $ab, $43
    db $ab, $43, $ab, $43, $ab, $43, $ab, $40
    db $ab, $40, $ab, $40, $ab, $40, $ab, $40

    ; 40
    db $ab, $40, $ab, $40, $ab, $40, $ab, $40
    db $ab, $40, $ab, $40, $ab, $40, $ab, $40
    db $ab, $41, $ab, $41, $ab, $41, $ab, $41
    db $ab, $41, $ab, $41, $ab, $41, $ab, $41

    ; 60
    db $ab, $41, $ab, $41, $ab, $41, $ab, $41
    db $ab, $41, $ab, $41, $ab, $41, $ab, $41
    db $ab, $41, $ab, $41, $ab, $41, $ab, $41
    db $ab, $41, $ab, $41, $ab, $41, $ab, $41

    ; 80
    db $ab, $41, $ab, $41, $ab, $41, $ab, $41
    db $ab, $41, $ab, $41, $ab, $41, $ab, $41
    db $ab, $41, $ab, $41, $ab, $41, $ab, $41
    db $ab, $41, $ab, $41, $ab, $41, $ab, $41

    ; a0
    db $ef, $42, $ef, $42, $ef, $42, $ef, $42
    db $ef, $42, $ef, $42, $ef, $42, $ef, $42
    db $ef, $42, $ef, $42, $ef, $42, $ef, $42
    db $ef, $42, $ef, $42, $ef, $42, $ef, $42

    ; c0
    db $ef, $43, $ef, $43, $ef, $43, $ef, $43
    db $ef, $43, $ef, $43, $ef, $43, $ef, $43
    db $ef, $43, $ef, $43, $ef, $43, $ef, $43
    db $ef, $43, $ef, $43, $ef, $43, $ef, $43

    ; d0
    db $ef, $43, $ef, $43, $ef, $43, $ef, $43
    db $ef, $43, $ef, $43, $ef, $43, $ef, $43
    db $ef, $43, $ef, $43, $ef, $43, $ef, $43
    db $ef, $43, $ef, $43, $ef, $43, $ef, $43
ExpectedDmaDataEnd: