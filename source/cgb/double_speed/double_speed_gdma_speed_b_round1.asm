INCLUDE "all.inc"

; Perform a basic HDMA (General Purpose) transfer in double speed mode.
; Check when LY changes.

EntryPoint:
    DisablePPU

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Change speed
    stop

    Nops 1

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

    EnablePPU

    ; Skip glitched line 0
    Nops 228

    ; Bit 7 = 0 (general purpose)
    ; Length = 640 bytes / $10 - 1 => 39 = $27
    ld a, $27
    ldh [rHDMA5], a

    ; --- transfer happens here ---
    Nops 32

    ldh a, [rLY]
    cp $03

    jp nz, TestFail
    jp TestSuccess

