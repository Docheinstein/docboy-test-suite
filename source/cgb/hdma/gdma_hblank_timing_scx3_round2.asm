INCLUDE "docboy.inc"

; Perform a basic HDMA (General Purpose) transfer.
; Check when STAT contains HBLANK.
; SCX=3

EntryPoint:
    ; Set SCX=3
    ld a, $03
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

    ; Bit 7 = 0 (General Purpose)
    ; Length = 64 bytes / $10 - 1 => 3
    ld a, $03
    ldh [rHDMA5], a

    ; --- transfer happens here ---

    Nops 22

    ldh a, [rSTAT]

    cp $80
    jp nz, TestFail

    jp TestSuccess
