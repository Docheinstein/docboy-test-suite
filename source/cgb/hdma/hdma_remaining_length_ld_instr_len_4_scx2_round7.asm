INCLUDE "docboy.inc"

; Perform a basic HDMA (HBlank) transfer.
; Check that HDMA5 contains the remaining transfer length and its timing.
; SCX=2

EntryPoint:
    DisablePPU

    ; Set SCX=2
    ld a, $02
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

    Nops 114


    ; Bit 7 = 1 (HBlank)
    ; Length = 80 bytes / $10 - 1 => 4
    ld a, $84
    ldh [rHDMA5], a

    ; --- transfer happens here ---

    Nops 372

    ld a, [rHDMA5]

    cp $01
    jp nz, TestFail

    jp TestSuccess
