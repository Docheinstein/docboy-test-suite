INCLUDE "all.inc"

; Perform a basic HDMA (HBlank) transfer at (glitched) line 0.
; Check when TIMA changes.

EntryPoint:
    DisablePPU

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

    ; Reset DIV
    xor a
    ldh [rDIV], a

    ; Reset TIMA
    ldh [rTIMA], a

    ; Enable timer at 262KHZ Hz
    ld a, TACF_START | TACF_262KHZ
    ldh [rTAC], a

    ; Enable PPU again
    EnablePPU

    ; Bit 7 = 1 (HBlank)
    ; Length = 640 bytes / $10 - 1 => 39 = $27
    ld a, $a7
    ldh [rHDMA5], a

    ; --- transfer happens here ---

REPT 144 * 40
    nop
ENDR

    Nops 3

    ldh a, [rTIMA]
    cp $fe
    jp nz, TestFail

    jp TestSuccess