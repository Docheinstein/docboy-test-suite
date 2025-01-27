INCLUDE "docboy.inc"

; Perform a basic HDMA (HBlank) transfer at (glitched) line 0.
; Check that HDMA5 contains the remaining transfer length and its timing.
; SCX=1

EntryPoint:
    DisablePPU

    ; Set SCX=1
    ld a, $01
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

    ; Enable PPU again
    EnablePPU

    ; Bit 7 = 1 (HBlank)
    ; Length = 96 bytes / $10 - 1 => 5
    ld a, $85
    ldh [rHDMA5], a

    ; --- transfer happens here ---

    Nops 467

    ldh a, [rHDMA5]

    cp $00
    jp nz, TestFail

    jp TestSuccess
