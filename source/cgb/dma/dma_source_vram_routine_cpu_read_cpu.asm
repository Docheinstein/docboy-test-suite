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
; CPU routine : HRAM (ff80) [cpu bus]
; CPU read    : RAM  (a000) [ext bus]
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

    ; Copy DMA transfer routine
    Memcpy $ff80, DmaTransferRoutine, DmaTransferRoutineEnd - DmaTransferRoutine

    ; Reset DE and HL
    ld de, $00
    ld hl, $00

    ; Jump to DMA transfer routine
    call $ff80

    ; Check result
    ld a, $af
    cp b

    jp nz, TestFailCGB
    jp TestSuccessCGB


DmaTransferRoutine:
    xor a ; af

    ; Start DMA
    ld a, $88
    ldh [rDMA], a

    Nops 4

    ; Try to read
    ld hl, $ff80
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