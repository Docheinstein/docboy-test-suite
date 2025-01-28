INCLUDE "all.inc"

; Perform a basic HDMA (HBlank) transfer.
; Check when STAT contains HBLANK.
; SCX=0

EntryPoint:
    ; Set SCX=0
    ld a, $00
    ldh [rSCX], a

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

    ; Enable PPU again
    EnablePPU

    ; Skip glitched line 0
    Nops 114

    ; Bit 7 = 1 (HBlank)
    ; Length = 64 bytes / $10 - 1 => 3
    ld a, $83
    ldh [rHDMA5], a

    ; --- transfer happens here ---

    Nops 55

    ldh a, [rSTAT]

    cp $80
    jp nz, TestFail

    jp TestSuccess
