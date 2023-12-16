; Args:
; \1: source
MACRO DmaTransfer
    ; Copy the DMA transfer routine to HRAM (ff80)
    Memcpy $ff80, DmaTransferRoutine, DmaTransferRoutineEnd - DmaTransferRoutine

    ; Set the DMA source
    ld hl, $ff81
    ld [hl], \1

    ; Jump to DMA transfer routine
    call $ff80
ENDM

MACRO ResetOAM
    DmaTransfer $20
ENDM


DmaTransferRoutine:
    ; Start DMA with source WRAM1 (c000)
    ld a, $c0
    ldh [rDMA], a

    ; Wait until the end of DMA
    ld a, 40
.dmaloop
    dec a
    jr nz, .dmaloop
    ret
DmaTransferRoutineEnd: