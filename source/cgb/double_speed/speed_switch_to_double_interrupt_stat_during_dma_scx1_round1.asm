INCLUDE "all.inc"

; Check the timing of DMA when speed is changed from single to double speed during
; an active DMA transfer STAT interrupt is triggered during the speed switch.

EntryPoint:
    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Reset PPU
    DisablePPU

    ; Set SCX=1
    ld a, $01
    ldh [rSCX], a

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

    EnablePPU

    ; Go to last line before VBlank
    LongWait 114 * 143

    ; Enable HBlank interrupt
    ld a, STATF_MODE00
    ldh [rSTAT], a

    ld a, IEF_STAT
    ldh [rIE], a

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

    Nops 1

    ; Read from OAM
    ld hl, $fe02
    ld a, [hl]

    cp $ff

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