INCLUDE "all.inc"

; Check the timing of speed switch when VBlank interrupt is triggered during a speed switch to double speed during DMA.

EntryPoint:
    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Reset PPU
    DisablePPU

    ; Reset DIV
    xor a
    ldh [rDIV], a

    ; Copy some data to DMA source (WRAM1 : c000)
    Memcpy $c000, Data, DataEnd - Data

    ; Copy the DMA transfer routine to HRAM (ff80)
    Memcpy $ff80, DmaTransferRoutine, DmaTransferRoutineEnd - DmaTransferRoutine

    ; Reset interrupts
    xor a
    ldh [rIF], a

    ; Enable VBLANK interrupt
    ld a, IEF_VBLANK
    ldh [rIE], a

    EnablePPU

    ; Go to VBlank
    Wait 114 * 143

    Nops 101

    ; Jump to DMA transfer routine
    call $ff80

DmaTransferRoutine:
    ; Start DMA with source WRAM1 (c000)
    ld a, $c0
    ldh [rDMA], a

    ; Change speed
    stop

    ; Wait until the end of DMA
    ld a, 38
.dmaloop
    dec a
    jr nz, .dmaloop

    Nops 2

    ; Read from OAM
    ld hl, $fe02
    ld a, [hl]

    cp $22

    jp nz, TestFail
    jp TestSuccess
DmaTransferRoutineEnd:

Data:
db $00, $11, $22, $33, $44, $55, $66, $77, $88, $99, $aa, $bb, $cc, $dd, $ee, $ff
db $00, $11, $22, $33, $44, $55, $66, $77, $88, $99, $aa, $bb, $cc, $dd, $ee, $ff
db $00, $11, $22, $33, $44, $55, $66, $77, $88, $99, $aa, $bb, $cc, $dd, $ee, $ff
db $00, $11, $22, $33, $44, $55, $66, $77, $88, $99, $aa, $bb, $cc, $dd, $ee, $ff
db $00, $11, $22, $33, $44, $55, $66, $77, $88, $99, $aa, $bb, $cc, $dd, $ee, $ff
db $00, $11, $22, $33, $44, $55, $66, $77, $88, $99, $aa, $bb, $cc, $dd, $ee, $ff
db $00, $11, $22, $33, $44, $55, $66, $77, $88, $99, $aa, $bb, $cc, $dd, $ee, $ff
db $00, $11, $22, $33, $44, $55, $66, $77, $88, $99, $aa, $bb, $cc, $dd, $ee, $ff
db $00, $11, $22, $33, $44, $55, $66, $77, $88, $99, $aa, $bb, $cc, $dd, $ee, $ff
db $00, $11, $22, $33, $44, $55, $66, $77, $88, $99, $aa, $bb, $cc, $dd, $ee, $ff
DataEnd: