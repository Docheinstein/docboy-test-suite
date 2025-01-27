;! MBC_TYPE=2
;! RAM_SIZE=3

INCLUDE "docboy.inc"

; Check DMA conflicts for:
;
; DMA source  : WRAM (c000) [ext bus]  -+
; DMA dest    : OAM  (fe00) [oam bus]   |
; CPU routine : VRAM (9000) [vram bus]  |
; CPU read    : RAM  (a000) [ext bus]  -+
;
; CPU should read the data read by DMA instead.

EntryPoint:
    DisablePPU

    ; Enable Cartridge RAM
    ld hl, $0000
    ld a, $0A
    ld [hl], a

    ; Copy CPU code
    Memcpy $9000, Code, CodeEnd - Code

    ; Copy DMA source data
    Memcpy $c000, DmaSourceData, DmaSourceDataEnd - DmaSourceData

    ; Set some data where CPU will read from
    ld hl, $a000
    ld a, $aa
    ld [hl], a

    ; Jump to CPU code
    call $9000

Code:
    ; Reset DE and HL
    ld de, $00
    ld hl, $00

    ; Start DMA
    ld a, $c0
    ldh [rDMA], a

    ; Try to read
    ld hl, $a000
    ld a, [hl]
    ld b, a

    ; Wait until the end of DMA
    ld a, 40
.dmaloop
    dec a
    jr nz, .dmaloop

    ; Check result
    ld a, $2c
    cp b

    jp nz, TestFail
    jp TestSuccess
CodeEnd:


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