INCLUDE "hardware.inc"
INCLUDE "common.inc"

; DMA source address cannot past 0xDF00.
; Trying to copy from FF00 should copy from DF00 instead.
;
; DMA source : IO   (ff00) [cpu bus]
; DMA dest   : OAM  (fe00) [oam bus]
; CPU routine: HRAM (ff80) [cpu bus]

EntryPoint:
    DisablePPU

    ; Copy some data to df00
    Memset $df00, $42, $20

    ; Copy the DMA transfer routine to HRAM (ff80)
    Memcpy $ff80, DmaTransferRoutine, DmaTransferRoutineEnd - DmaTransferRoutine

    ; Jump to DMA transfer routine
    call $ff80

    ; Read from df00: we should read 42
    Memtest $df00, $42
    jp nz, TestFail

    jp TestSuccess

DmaTransferRoutine:
    ; Try to start DMA with source IO (ff00).
    ; It should read from df00 instead.
    ld a, $ff
    ldh [rDMA], a

    ; Wait until the end of DMA
    ld a, 40
.dmaloop
    dec a
    jr nz, .dmaloop
    ret
DmaTransferRoutineEnd: