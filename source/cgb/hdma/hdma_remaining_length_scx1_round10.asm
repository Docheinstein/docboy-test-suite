INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "cgb.inc"

; Perform a basic HDMA (HBlank) transfer.
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

    Nops 114


    ; Bit 7 = 1 (HBlank)
    ; Length = 80 bytes / $10 - 1 => 4
    ld a, $84
    ldh [rHDMA5], a

    ; --- transfer happens here ---

    Nops 477

    ldh a, [rHDMA5]

    cp $ff
    jp nz, TestFailCGB

    jp TestSuccessCGB
