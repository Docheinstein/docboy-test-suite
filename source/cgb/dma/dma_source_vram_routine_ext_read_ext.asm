;! MBC_TYPE=2
;! RAM_SIZE=3

INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "cgb.inc"
INCLUDE "print.inc"
INCLUDE "debug.inc"

; Check DMA conflicts for:
;
; DMA source  : VRAM (8800) [vram bus]
; DMA dest    : OAM  (fe00) [oam bus]
; CPU routine : ROM  (0000) [ext bus]
; CPU read    : ROM  (0000) [ext bus]
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

    ; Reset DE and HL
    ld de, $00
    ld hl, $00

    ; Start DMA
    ld a, $88
    ldh [rDMA], a

    ; Try to execute some code while DMA is in progress.
REPT 90
    inc d
    inc e
ENDR

    ; Check result
    ld a, $5a
    cp d
    jp nz, TestFailCGB
    cp e
    jp nz, TestFailCGB

    xor a
    cp h
    jp nz, TestFailCGB
    cp l
    jp nz, TestFailCGB

    jp TestSuccessCGB


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