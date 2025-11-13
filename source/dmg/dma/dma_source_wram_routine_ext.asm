CartridgeType $02
RamSize $03

INCLUDE "all.inc"

; Check DMA conflicts for:
;
; DMA source  : WRAM (c000) [ext bus] -+
; DMA dest    : OAM  (fe00) [oam bus]  |
; CPU routine : ROM  (0000) [ext bus] -+
; CPU read    : ROM  (0000) [ext bus]
;
; CPU should execute instructions from DMA source.

EntryPoint:
    DisablePPU

    ; Enable Cartridge RAM
    ld hl, $0000
    ld a, $0A
    ld [hl], a

    ; Copy DMA source data
    Memcpy $c000, DmaSourceData, DmaSourceDataEnd - DmaSourceData

    ; Reset DE and HL
    ld de, $00
    ld hl, $00

    ; Start DMA
    ld a, $c0
    ldh [rDMA], a

    ; Try to execute some code while DMA is in progress.
REPT 90
    inc d
    inc e
ENDR

    ; Check result
    ld a, $0a
    cp d
    jp nz, TestFail
    cp e
    jp nz, TestFail

    ld a, $50
    cp h
    jp nz, TestFail
    cp l
    jp nz, TestFail

    jp TestSuccess


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