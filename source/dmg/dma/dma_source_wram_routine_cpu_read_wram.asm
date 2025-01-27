;! MBC_TYPE=2
;! RAM_SIZE=3

INCLUDE "docboy.inc"

; Check DMA conflicts for:
;
; DMA source  : WRAM (c000) [ext bus] -+
; DMA dest    : OAM  (fe00) [oam bus]  |
; CPU routine : HRAM (ff80) [cpu bus]  |
; CPU read    : WRAM (c000) [ext bus] -+
;
; CPU should read the data read by DMA instead.

EntryPoint:
    DisablePPU

    ; Enable Cartridge RAM
    ld hl, $0000
    ld a, $0A
    ld [hl], a

    ; Copy DMA source data
    Memcpy $c000, DmaSourceData, DmaSourceDataEnd - DmaSourceData

    ; Copy DMA transfer routine
    Memcpy $ff80, DmaTransferRoutine, DmaTransferRoutineEnd - DmaTransferRoutine

    ; Set some data where CPU will read from
    ld hl, $c000
    ld a, $aa
    ld [hl], a

    ; Reset DE and HL
    ld de, $00
    ld hl, $00

    ; Jump to DMA transfer routine
    call $ff80

    ; Check result
    ld a, $2c
    cp b

    jp nz, TestFail
    jp TestSuccess


DmaTransferRoutine:
    xor a ; af

    ; Start DMA
    ld a, $c0
    ldh [rDMA], a

    Nops 4

    ; Try to read
    ld hl, $c000
    ld a, [hl]
    ld b, a

    ; Wait until the end of DMA
    ld a, 40
.dmaloop
    dec a
    jr nz, .dmaloop

    ret
DmaTransferRoutineEnd:


DmaSourceData:
    ; INC H, INC L, ...
    db $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C
    db $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C
    db $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C
    db $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C
    db $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C
    db $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C
    db $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C
    db $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C
    db $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C
    db $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C, $24, $2C
DmaSourceDataEnd: