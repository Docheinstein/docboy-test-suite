INCLUDE "all.inc"

; Perform a basic HDMA (General Purpose) transfer.
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

    ; Bit 7 = 0 (general purpose)
    ; Length = 640 bytes / $10 - 1 => 39 = $27
    ld a, $27
    ldh [rHDMA5], a

    ; --- transfer happens here ---

    Nops 2

    ldh a, [rTIMA]
    cp $52
    jp nz, TestFail

    jp TestSuccess

