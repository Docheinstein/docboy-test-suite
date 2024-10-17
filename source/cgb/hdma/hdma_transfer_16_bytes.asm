INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "cgb.inc"

; Perform a basic HDMA (HBlank) transfer.
; Check that the first chunk of bytes instantly transferred.

EntryPoint:
    DisablePPU

    ; Copy data to WRAM2
    Memset $D000, $f0, 16

    ; Source address = D000
    ld a, $D0
    ldh [rHDMA1], a

    ld a, $00
    ldh [rHDMA2], a

    ; Dest address = 8000
    ld a, $80
    ldh [rHDMA3], a

    ld a, $00
    ldh [rHDMA4], a

    ; Enable PPU again
    EnablePPU

    ; Bit 7 = 1 (HBlank)
    ; Length = 16 bytes / $10 - 1 => 0
    ld a, $80
    ldh [rHDMA5], a

    DisablePPU

    ; Check that the first chunk of 16 bytes are transferred.
    ld hl, $800f
    ld a, [hl]

    cp $f0
    jp nz, TestFailCGB

    jp TestSuccessCGB