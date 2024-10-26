INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "cgb.inc"

; Perform a HDMA (HBlank) transfer.
; Write only to HDMA3, HDMA4.

EntryPoint:
    DisablePPU

    ; Copy data to WRAM2
    Memcpy $D430, VramData, VramDataEnd - VramData

    ; Set VRAM data
    Memset $8000, $ab, $2000

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

    ; --- transfer happens here ---

    ; Wait for enough HBlanks to happen
    ; (no precise timing check)
    Nops 4 * 114

    ; Disable the PPU again
    DisablePPU

    Memcmp $8000, VramData, $40
    jp nz, TestFailCGB

    jp TestSuccessCGB

VramData:
    db $00, $11, $22, $33, $44, $55, $66, $77, $88, $99, $aa, $bb, $cc, $dd, $ee, $ff
    db $11, $22, $33, $44, $55, $66, $77, $88, $99, $aa, $bb, $cc, $dd, $ee, $ff, $00
    db $22, $33, $44, $55, $66, $77, $88, $99, $aa, $bb, $cc, $dd, $ee, $ff, $00, $11
    db $33, $44, $55, $66, $77, $88, $99, $aa, $bb, $cc, $dd, $ee, $ff, $00, $11, $22
VramDataEnd: