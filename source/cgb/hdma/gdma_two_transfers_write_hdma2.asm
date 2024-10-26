INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "cgb.inc"

; Perform two HDMA (General Purpose) transfers one after the other.
; Reset source by writing to HDMA2.

EntryPoint:
    DisablePPU

    ; Copy data to WRAM2
    Memcpy $D000, VramData, VramDataEnd - VramData

    ; Set VRAM data
    Memset $8000, $ab, $80

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

    ; Bit 7 = 0 (general purpose)
    ; Length = 64 bytes / $10 - 1 => 1
    ld a, $03
    ldh [rHDMA5], a

    ; --- first transfer happens here ---

    Nops 10

    ; Write HDMA2: reset cursor
    ld a, $00
    ldh [rHDMA2], a

    ; Start it again
    ld a, $03
    ldh [rHDMA5], a

    ; --- second transfer happens here ---

    Memcmp $8000, VramData, $40
    Memcmp $8040, VramData, $40

    jp nz, TestFailCGB

    jp TestSuccessCGB

VramData:
    db $00, $11, $22, $33, $44, $55, $66, $77, $88, $99, $aa, $bb, $cc, $dd, $ee, $ff
    db $11, $22, $33, $44, $55, $66, $77, $88, $99, $aa, $bb, $cc, $dd, $ee, $ff, $00
    db $22, $33, $44, $55, $66, $77, $88, $99, $aa, $bb, $cc, $dd, $ee, $ff, $00, $11
    db $33, $44, $55, $66, $77, $88, $99, $aa, $bb, $cc, $dd, $ee, $ff, $00, $11, $22
VramDataHalf:
    db $44, $55, $66, $77, $88, $99, $aa, $bb, $cc, $dd, $ee, $ff, $00, $11, $22, $33
    db $55, $66, $77, $88, $99, $aa, $bb, $cc, $dd, $ee, $ff, $00, $11, $22, $33, $44
    db $66, $77, $88, $99, $aa, $bb, $cc, $dd, $ee, $ff, $00, $11, $22, $33, $44, $55
    db $77, $88, $99, $aa, $bb, $cc, $dd, $ee, $ff, $00, $11, $22, $33, $44, $55, $66
VramDataEnd: