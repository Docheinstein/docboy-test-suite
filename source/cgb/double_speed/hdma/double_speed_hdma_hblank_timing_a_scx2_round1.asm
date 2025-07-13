INCLUDE "all.inc"

; Perform a basic HDMA (HBlank) transfer.
; Check when STAT contains HBLANK.
; SCX=2

EntryPoint:
    DisablePPU

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Change speed
    stop

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

    ; Skip glitched line 0
    Nops 228

    ; Bit 7 = 1 (HBlank)
    ; Length = 64 bytes / $10 - 1 => 3
    ld a, $83
    ldh [rHDMA5], a

    ; --- transfer happens here ---

    Nops 117

    ldh a, [rSTAT]

    cp $83
    jp nz, TestFail

    jp TestSuccess
