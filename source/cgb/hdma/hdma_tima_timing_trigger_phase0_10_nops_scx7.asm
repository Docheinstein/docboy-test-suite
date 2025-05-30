INCLUDE "all.inc"

; Check the timing of HDMA trigger with different SCX and delays.
; HDMA start should be postponed to the end of the current instruction.

EntryPoint:
    DisablePPU

    ; Set SCX=7
    ld a, $07
    ldh [rSCX], a

    ; Set HDMA source data
    Memset $c000, $34, 160

    ; Reset HDMA destination
    Memset $8000, $cd, 160

    ; Set HDMA source address
    ld a, $C0
    ldh [rHDMA1], a

    ld a, $00
    ldh [rHDMA2], a

    ; Set HDMA destination address
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

    ; Enable PPU
    EnablePPU

    ; Skip glitched line 0
    Nops 160

    ; Start HDMA
    ; Bit 7 = 1 (HBlank)
    ; Length = 16 bytes / $10 - 1 => 0
    ld a, $80
    ldh [rHDMA5], a

    Nops 10

    ldh a, [rTIMA]

    ld c, a
    ld a, $2d
    cp c
    jp nz, TestFail

    jp TestSuccess