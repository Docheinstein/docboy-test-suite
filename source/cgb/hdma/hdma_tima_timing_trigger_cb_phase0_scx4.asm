INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "cgb.inc"

; Check the timing of HDMA trigger while executing CB instructions with different SCX.

EntryPoint:
    DisablePPU

    ; Set SCX=4
    ld a, $04
    ldh [rSCX], a

    ; Set HDMA source data
    Memset $c000, $02, 160

    ; Reset HDMA destination
    Memset $8000, $01, 160

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

    ld hl, $8000

    ; Enable PPU
    EnablePPU

    ; Skip glitched line 0
    Nops 160

    ; Start HDMA
    ; Bit 7 = 1 (HBlank)
    ; Length = 16 bytes / $10 - 1 => 0
    ld a, $80
    ldh [rHDMA5], a

REPT 4
   db $cb, $16
ENDR

    DisablePPU

    ld a, [hl]

    cp $05
    jp nz, TestFailCGB

    jp TestSuccessCGB