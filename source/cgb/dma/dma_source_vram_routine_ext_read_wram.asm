CartridgeType $02
RamSize $03

INCLUDE "all.inc"

; Check DMA conflicts for:
;
; DMA source  : VRAM (8800) [vram bus]
; DMA dest    : OAM  (fe00) [oam bus]
; CPU routine : ROM  (0000) [ext bus]
; CPU read    : WRAM (C000) [wram bus]
;
; There should be no conflicts.

EntryPoint:
    DisablePPU

    ; Enable Cartridge RAM
    ld hl, $0000
    ld a, $0A
    ld [hl], a

    ; Copy DMA source data
    Memcpy $8800, DmaSourceData, DmaSourceDataEnd - DmaSourceData

    ; Set some data where CPU will read from
    ld hl, $c000
    ld a, $aa
    ld [hl], a

    ; Reset DE and HL
    ld de, $00
    ld hl, $00

    ; Start DMA
    ld a, $88
    ldh [rDMA], a

    ; Try to read
    ld hl, $c000
    ld a, [hl]
    ld b, a

    ; Wait until the end of DMA
    ld a, 40
.dmaloop
    dec a
    jr nz, .dmaloop

    ; Check result
    ld a, $aa
    cp b

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