INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Check what happens by trying to write to HRAM while DMA is copying from WRAM1.
; It should correctly write to HRAM since DMA is using a different bus.
;
; DMA source : WRAM1 (c000) [ext bus]
; DMA dest   : OAM   (fe00) [oam bus]
; CPU routine: HRAM  (ff80) [cpu bus]
; CPU write:   HRAM  (ff88) [cpu bus]

EntryPoint:
    DisablePPU

    ; Copy a certain value to HRAM (ff88)
    ld a, $42
    ld bc, $ff88
    ld [bc], a

    ; Copy some code to DMA source (WRAM1 : c000)
    Memcpy $c000, Code, CodeEnd - Code

    ; Reset DE
    ld de, $00

    ; Start DMA with source WRAM1 (c000)
    ld a, $c0
    ldh [rDMA], a

    ; Try to execute some code while DMA is in progress.
    ; We should read the data we copied to WRAM1 instead.
REPT 90
    inc d
    inc e
ENDR

    ; Check value of ff88: we should read 1
    Memtest $ff88, $01
    jp nz, TestFail

    jp TestSuccess

Code:
    ld a, $01    ; Since inc a is not executed, this ends up in ff88
    ld hl, $ff80 ; HRAM
REPT 10
    ld [hli], a  ; Executed and will have effect
    inc a        ; Not executed: a remains $01
ENDR
    Nops 140     ; Covers the rest of DMA transfer
CodeEnd: