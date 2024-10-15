INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "cgb.inc"

; Perform a basic HDMA (General Purpose) transfer.
; Check that PPU is not halted.

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

    EnablePPU

    ; Bit 7 = 0 (general purpose)
    ; Length = 640 bytes / $10 - 1 => 39 = $27
    ld a, $27
    ldh [rHDMA5], a

    ; --- transfer happens here ---

    Nops 11

    ldh a, [rLY]

    cp $02
    jp nz, TestFailCGB

    jp TestSuccessCGB

