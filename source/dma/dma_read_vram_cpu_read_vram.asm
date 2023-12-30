INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Check what happens by trying to read VRAM while DMA is copying from VRAM.
; It should correctly read from VRAM since DMA is using a different bus.
;
; DMA source : VRAM  (8800) [vram bus] -+
; DMA dest   : OAM   (fe00) [oam bus]   |
; CPU routine: HRAM  (ff80) [cpu bus]   |
; CPU read:    VRAM  (9000) [vram bus] -+

EntryPoint:
    DisablePPU

    ; Write something to 9000
    ld hl, $9000
    ld a, $42
    ld [hl], a

    ; Copy random data to DMA source (VRAM : 8800)
    Memcpy $8800, Data, DataEnd - Data

    ; Copy the DMA transfer routine to HRAM (ff80)
    Memcpy $ff80, DmaTransferRoutine, DmaTransferRoutineEnd - DmaTransferRoutine

    ; Jump to DMA transfer routine
    call $ff80

    ; Check result: we should have read 42
    ld a, $24
    cp b

    jp nz, TestFail
    jp TestSuccess

DmaTransferRoutine:
    ld hl, $9000 ; VRAM

    ; Start DMA with source VRAM (8800)
    ld a, $88
    ldh [rDMA], a

    Nops 10

    ; Try to read from VRAM (9000): we should read 42
    ld a, [hl]
    ld b, a

    ; Wait until the end of DMA
    ld a, 40
.dmaloop
    dec a
    jr nz, .dmaloop

    ret
DmaTransferRoutineEnd:


Data:
db $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C,
db $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C,
db $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C,
db $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C,
db $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C,
db $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C,
db $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C,
db $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C,
db $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C,
db $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C,
DataEnd: