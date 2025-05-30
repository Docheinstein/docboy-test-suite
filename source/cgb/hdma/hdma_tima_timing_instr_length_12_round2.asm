INCLUDE "all.inc"

; Perform a basic HDMA (HBlank) transfer.
; Check that the length of the CPU instruction that is executing
; while the CPU is stalled does not effect HDMA timing.

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

    ; Skip glitched line 0
    Nops 114

    ; Bit 7 = 1 (HBlank)
    ; Length = 640 bytes / $10 - 1 => 39 = $27
    ld a, $a7
    ldh [rHDMA5], a

    ; --- transfer happens here ---

REPT 144 * 40 / 3
    ld de, $abab
ENDR

    Nops 1

    ldh a, [rTIMA]
    cp $1a
    jp nz, TestFail

    jp TestSuccess