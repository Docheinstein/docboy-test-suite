INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Check what happens by trying to fetch operations from ROM while DMA is copying from VRAM.
; It should correctly read from ROM since DMA is using a different bus.
;
; DMA source : VRAM (8800) [vram bus]
; DMA dest   : OAM  (fe00) [oam bus]
; CPU routine: ROM  (0000) [ext bus]

EntryPoint:
    WaitVBlank

    ; Copy some code to DMA source (VRAM : 8800)
    Memcpy $8800, Code, CodeEnd - Code

    ; Reset DE and HL
    ld de, $00
    ld hl, $00

    ; Start DMA with source VRAM (8800)
    ld a, $88
    ldh [rDMA], a

    ; Try to execute some code while DMA is in progress.
    ; We should read the code correctly since the DMA transfer uses a separate bus.
REPT 90
    inc d
    inc e
ENDR

    ; Check DE
    ld a, $5a
    cp d
    jp nz, TestFail
    cp e
    jp nz, TestFail

    ; Check HL
    xor a
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