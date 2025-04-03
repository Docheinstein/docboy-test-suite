INCLUDE "all.inc"

; STOP in the middle of a basic HDMA (General Purpose) transfer.
; Then read remaining length.

EntryPoint:
    DisablePPU

    ; Copy data to WRAM2
    Memcpy $D000, HdmaVramData, HdmaVramDataEnd - HdmaVramData

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
    Nops 114

    ; Bit 7 = 1 (general purpose)
    ; Length = 64 bytes / $10 - 1 => 3
    ld a, $83
    ldh [rHDMA5], a

    stop

    ldh a, [rHDMA5]
    cp $03

    jp nz, TestFail
    jp TestSuccess

HdmaVramData:
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
HdmaVramDataEnd: