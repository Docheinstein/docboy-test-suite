INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Check what happens by trying to write to WRAM2 while DMA is copying from WRAM1.
; It should be ignored since DMA is using the same bus.
;
; DMA source : WRAM1 (c000) [ext bus] -+
; DMA dest   : OAM   (fe00) [oam bus]  |
; CPU routine: HRAM  (ff80) [cpu bus]  |
; CPU write:   WRAM2 (d000) [ext bus] -+

EntryPoint:
    DisablePPU

    ; Copy a certain value to WRAM2 (d008)
    ld a, $42
    ld bc, $d008
    ld [bc], a

    ; Copy some code to DMA source (WRAM1 : c000)
    Memcpy $c000, Code, CodeEnd - Code

    ; Reset DE
    ld de, $00

    ; Start DMA with source WRAM1 (c000)
    ld a, $c0
    ldh [rDMA], a

    ; Try to execute some code while DMA is in progress.
    ; We should read the code we copied to WRAM1 instead.
REPT 90
    inc d
    inc e
ENDR

    ; Check value of d008: we should read $42
    Memcheck $d008, $42
    jp nz, TestFail

    jp TestSuccess

Code:
    ld a, $01
    ld hl, $d000 ; WRAM2
REPT 10
    ld [hli], a  ; Executed, but won't have effect
    inc a        ; Not executed
ENDR
    Nops 140     ; Covers the rest of DMA transfer
CodeEnd: