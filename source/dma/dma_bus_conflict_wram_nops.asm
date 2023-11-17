INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Check what happens by trying to fetch operations while DMA is copying from WRAM.

EntryPoint:
    ; Reset DE
    ld de, $00

    ; Start DMA copying from WRAM1 (c000)
    ld a, $c0
    ldh [rDMA], a

    ; Try to execute some code while DMA is in progress.
    ; We should read a bunch of 00 (nop) instead.
REPT 90
    inc d
    inc e
ENDR

    ; Check DE
    ld a, $0a
    cp d
    jp nz, TestFail
    cp e
    jp nz, TestFail

    jp TestSuccess
