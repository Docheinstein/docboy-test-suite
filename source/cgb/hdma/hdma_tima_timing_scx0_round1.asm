INCLUDE "all.inc"

; Perform a basic HDMA (HBlank) transfer.
; Check SCX does not effect HDMA timing.

EntryPoint:
    DisablePPU

    ; Set SCX=0
    ld a, $00
    ldh [rSCX], a

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
    ; Length = 16 bytes / $10 - 1 => 0
    ld a, $80
    ldh [rHDMA5], a

    ; --- transfer happens here ---

REPT 144 * 40
    nop
ENDR

    Nops 3

    ldh a, [rTIMA]

    cp $c2
    jp nz, TestFail

    jp TestSuccess
