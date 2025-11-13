CartridgeType $02
RamSize $03

INCLUDE "all.inc"

; Check DMA conflicts for:
;
; DMA source  : RAM  (a000) [ext bus]
; DMA dest    : OAM  (fe00) [oam bus]
; CPU routine : WRAM (c000) [wram bus]
; CPU read    : VRAM (9000) [vram bus]
;
; There should be no conflicts.

EntryPoint:
    DisablePPU

    ; Enable Cartridge RAM
    ld hl, $0000
    ld a, $0A
    ld [hl], a

    ; Copy CPU code
    Memcpy $c000, Code, CodeEnd - Code

    ; Copy DMA source data
    Memcpy $a000, DmaSourceData, DmaSourceDataEnd - DmaSourceData

    ; Set some data where CPU will read from
    ld hl, $9000
    ld a, $aa
    ld [hl], a

    ; Jump to CPU code
    call $c000


Code:
    ; Reset DE and HL
    ld de, $00
    ld hl, $00

    ; Start DMA
    ld a, $a0
    ldh [rDMA], a

    ; Try to read
    ld hl, $9000
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