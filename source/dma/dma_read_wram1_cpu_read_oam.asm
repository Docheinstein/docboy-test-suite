INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Check what happens by trying to read OAM while DMA is copying from WRAM1.
; It should read FF since OAM is taken by DMA.
;
; DMA source : WRAM1 (c000) [ext bus]
; DMA dest   : OAM   (fe00) [oam bus] -+
; CPU routine: HRAM  (ff80) [cpu bus]  |
; CPU read:    OAM   (fe00) [oam bus] -+

EntryPoint:
    DisablePPU

    ; Copy random data to DMA source (WRAM1 : c000)
    Memcpy $c000, Data, DataEnd - Data

    ; Copy the DMA transfer routine to HRAM (ff80)
    Memcpy $ff80, DmaTransferRoutine, DmaTransferRoutineEnd - DmaTransferRoutine

    ; Jump to DMA transfer routine
    call $ff80

    ; Check result: we should have read ff
    ld a, $ff
    cp b

    jp nz, TestFail
    jp TestSuccess

DmaTransferRoutine:
    ld hl, $fe00 ; OAM

    ; Start DMA with source WRAM1 (c000)
    ld a, $c0
    ldh [rDMA], a

    ; Try to read from OAM (fe00): we should read FF
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