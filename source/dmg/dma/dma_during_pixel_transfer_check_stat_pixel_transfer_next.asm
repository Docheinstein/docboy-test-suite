INCLUDE "all.inc"

; When DMA is running, STAT mode is 0 either in HBlank or in OAM scan.
; This change shouldn't affect interrupts.

EntryPoint:
    DisablePPU

    ; Copy some data to DMA source (WRAM1 : c000)
    Memcpy $c000, Data, DataEnd - Data

    ; Copy the DMA transfer routine to HRAM (ff80)
    Memcpy $ff80, DmaTransferRoutine, DmaTransferRoutineEnd - DmaTransferRoutine

    EnablePPU

    ; Skip glitched line 0
    ; Go to Pixel Transfer of line 1
    Nops 160

    ; Jump to DMA transfer routine
    call $ff80

    ld a, $83
    cp b
    jp nz, TestFail

    jp TestSuccess

DmaTransferRoutine:
    ; Start DMA with source WRAM1 (c000)
    ld a, $c0
    ldh [rDMA], a

    ; Wait Pixel Transfer of next line
    ld a, 24
.waitloop
    dec a
    jr nz, .waitloop

    ld a, [rSTAT]
    ld b, a

    ; Wait until the end of DMA
    ld a, 40
.dmaloop
    dec a
    jr nz, .dmaloop
    ret
DmaTransferRoutineEnd:


Data:
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
DataEnd: