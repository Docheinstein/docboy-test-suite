INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Running DMA during OAM scan should prevent PPU to read from OAM at all.

EntryPoint:
    DisablePPU

    ; Copy data to OAM
    Memcpy $fe00, Data, DataEnd - Data

    ; Copy data to DMA source
    Memcpy $c000, Data, DataEnd - Data

    ; Copy DMA transfer routine
    Memcpy $ff80, DmaTransferRoutine, DmaTransferRoutineEnd - DmaTransferRoutine

    ; Jump to DMA transfer routine
    call $ff80

    Nops 31

    ; Should be in HBlank

    ld a, [rSTAT]
    cp $80

    jp nz, TestFail
    jp TestSuccess

DmaTransferRoutine:
    ; Start DMA with source WRAM1 (c000)
    ld a, $c0
    ldh [rDMA], a

    ; Wait a bit and enable PPU so that OAM Scan of the
    ; second scanline is aligned with the end of DMA transfer
    ld a, 9
.dmaloop2
    dec a
    jr nz, .dmaloop2

    EnablePPU

    ; Wait until the end of DMA
    ld a, 37
.dmaloop1
    dec a
    jr nz, .dmaloop1

    ret
DmaTransferRoutineEnd:

Data:
; fe00
db $00, $00, $00, $00
db $00, $00, $00, $00
db $00, $ff, $ff, $ff
db $00, $ff, $ff, $ff
db $00, $ff, $ff, $ff
db $00, $ff, $ff, $ff
db $00, $ff, $ff, $ff
db $00, $ff, $ff, $ff

; fe20
db $00, $ff, $ff, $ff
db $00, $ff, $ff, $ff
db $00, $ff, $ff, $ff
db $00, $ff, $ff, $ff
db $10, $20, $00, $00
db $10, $20, $00, $00
db $10, $20, $00, $00
db $10, $20, $00, $00

; fe40
db $10, $20, $00, $00
db $10, $20, $00, $00
db $10, $20, $00, $00
db $10, $20, $00, $00
db $00, $ff, $ff, $ff
db $00, $ff, $ff, $ff
db $00, $ff, $ff, $ff
db $00, $ff, $ff, $ff

; fe60
db $00, $ff, $ff, $ff
db $00, $ff, $ff, $ff
db $00, $ff, $ff, $ff
db $00, $ff, $ff, $ff
db $00, $ff, $ff, $ff
db $00, $ff, $ff, $ff
db $00, $ff, $ff, $ff
db $00, $ff, $ff, $ff

; fe80
db $00, $ff, $ff, $ff
db $00, $ff, $ff, $ff
db $00, $ff, $ff, $ff
db $00, $ff, $ff, $ff
db $00, $ff, $ff, $ff
db $00, $ff, $ff, $ff
db $00, $ff, $ff, $ff
db $00, $ff, $ff, $ff
DataEnd:
