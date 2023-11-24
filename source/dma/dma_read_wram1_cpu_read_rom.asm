INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Check what happens by trying to fetch operations from ROM while DMA is copying from WRAM.
; It should conflict with DMA since it is using the same bus.

; DMA source : WRAM1 (8800) [ext bus] -+
; DMA dest   : OAM   (fe00) [oam bus]  |
; CPU routine: ROM   (0000) [ext bus] -+

EntryPoint:
    WaitVBlank

    ; Copy some code to DMA source (WRAM1 : c000)
    Memcpy $c000, Code, CodeEnd - Code

    ; Reset DE and HL
    ld de, $00
    ld hl, $00

    ; Start DMA with source WRAM1 (c000)
    ld a, $c0
    ldh [rDMA], a

    ; Try to execute some code while DMA is in progress.
    ; We should read the data we copied to WRAM1 instead (inc h, inc l).
REPT 90
    inc d
    inc e
ENDR

    ; Check DE
    ld a, $0a
    cp d
    jp nz, TestFail
    cp e
    jp nz, TestFail

    ; Check HL
    ld a, $50
    cp h
    jp nz, TestFail
    cp l
    jp nz, TestFail

    ; Check DMA transferred data
    Memcmp Code, $fe00, $02
    jp nz, TestFail

    jp TestSuccess

Code:
; INC H, INC L, ...
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
CodeEnd: