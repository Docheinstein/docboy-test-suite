INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "cgb.inc"

; Perform a basic HDMA (General Purpose) transfer.
; Check the maximum amount of data that can be transferred ($800 bytes)

EntryPoint:
    DisablePPU

    ; Set 8192 bytes in WRAM0 and WRAM1
    Memset $C000, $f0, $2000

    ; Source address = C000
    ld a, $C0
    ldh [rHDMA1], a

    ld a, $00
    ldh [rHDMA2], a

    ; Dest address = 8000
    ld a, $80
    ldh [rHDMA3], a

    ld a, $00
    ldh [rHDMA4], a

    ; Bit 7 = 0 (general purpose)
    ld a, $7f
    ldh [rHDMA5], a

    ; --- transfer happens here ---

    Memcmp $8000, $C000, $800
    jp nz, TestFailCGB

    ld hl, $8800
    ld a, [hl]

    cp $00
    jp nz, TestFailCGB

    jp TestSuccessCGB
