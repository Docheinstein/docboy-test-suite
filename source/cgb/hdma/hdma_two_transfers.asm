INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "cgb.inc"

; Perform two HDMA (HBlank) transfers one after the other.

EntryPoint:
    DisablePPU

    ; Copy data to WRAM2
    Memcpy $D000, VramData, VramDataEnd - VramData

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

    ; Bit 7 = 1 (HBlank)
    ; Length = 64 bytes / $10 - 1 => 3
    ld a, $83
    ldh [rHDMA5], a

    ; --- first transfer happens here ---

    ; Wait for enough HBlanks to happen
    ; (no precise timing check)
    Nops 4 * 114

    ldh [rHDMA5], a

    ; --- second transfer happens here ---

    ; Wait for enough HBlanks to happen
    ; (no precise timing check)
    Nops 4 * 114

    ; Disable the PPU again
    DisablePPU

    Memcmp $8000, VramData, VramDataEnd - VramData
    jp nz, TestFailCGB

    jp TestSuccessCGB

VramData:
    db $00, $11, $22, $33, $44, $55, $66, $77
    db $88, $99, $aa, $bb, $cc, $dd, $ee, $ff
    db $11, $22, $33, $44, $55, $66, $77, $88
    db $99, $aa, $bb, $cc, $dd, $ee, $ff, $00
    db $22, $33, $44, $55, $66, $77, $88, $99
    db $aa, $bb, $cc, $dd, $ee, $ff, $00, $11
    db $33, $44, $55, $66, $77, $88, $99, $aa
    db $bb, $cc, $dd, $ee, $ff, $00, $11, $22
VramDataHalf:
    db $44, $55, $66, $77, $88, $99, $aa, $bb
    db $cc, $dd, $ee, $ff, $00, $11, $22, $33
    db $55, $66, $77, $88, $99, $aa, $bb, $cc
    db $dd, $ee, $ff, $00, $11, $22, $33, $44
    db $66, $77, $88, $99, $aa, $bb, $cc, $dd
    db $ee, $ff, $00, $11, $22, $33, $44, $55
    db $77, $88, $99, $aa, $bb, $cc, $dd, $ee
    db $ff, $00, $11, $22, $33, $44, $55, $66
VramDataEnd: