INCLUDE "all.inc"

; Running DMA during OAM scan should prevent PPU to read from OAM at all.

EntryPoint:
    DisablePPU

    ; Reset VRAM
    ; Reset VRAM
    Memset $8000, $00, $2000

    ; Reset OAM
    Memset $fe00, $00, 160

    ; Copy OAM data
    Memcpy $fe00, OamData, OamDataEnd - OamData

    ; Copy DMA transfer routine
    Memcpy $ff80, DmaTransferRoutine, DmaTransferRoutineEnd - DmaTransferRoutine

    EnablePPU_WithSprites

    ; Wait
    Nops 114 * 3

    Nops 104

    ; Jump to DMA transfer routine
    call $ff80

    ; Check STAT
    ld a, b
    cp $83

    jp nz, TestFail
    jp TestSuccess

DmaTransferRoutine:
    ; Start DMA with source WRAM1 (c000)
    ld a, $c0
    ldh [rDMA], a

    ; Wait until end of Pixel Transfer
    Nops 81

    ldh a, [rSTAT]
    ld b, a

    ; Wait until the end of DMA
    ld a, 40
.dmaloop
    dec a
    jr nz, .dmaloop

    ret
DmaTransferRoutineEnd:

OamData:
db 20, $10, $01, $00
db 20, $18, $01, $00
db 20, $20, $01, $00
db 20, $28, $01, $00
db 20, $30, $01, $00
db 20, $38, $01, $00
db 20, $40, $01, $00
db 20, $48, $01, $00
db 20, $50, $01, $00
db 20, $58, $01, $00
OamDataEnd:
