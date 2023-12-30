DEF DmaTransferRoutine = $ff80

; Args:
; \1: source
MACRO SetupDmaTransfer
    ; Copy the DMA transfer routine to HRAM (ff80)
    Memcpy $ff80, DmaTransferRoutineCode, DmaTransferRoutineCodeEnd - DmaTransferRoutineCode

    ; Set the DMA source
    ld hl, $ff81
    ld [hl], \1
ENDM

MACRO ResetOAM
    SetupDmaTransfer $20
    call DmaTransferRoutine
ENDM


DmaTransferRoutineCode:
    ; Start DMA with source WRAM1 (c000)
    ld a, $c0
    ldh [rDMA], a

    ; Wait until the end of DMA
    ld a, 40
.dmaloop_
    dec a
    jr nz, .dmaloop_
    ret
DmaTransferRoutineCodeEnd: