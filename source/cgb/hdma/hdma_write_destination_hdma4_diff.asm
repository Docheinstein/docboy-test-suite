INCLUDE "all.inc"

; Perform a HDMA (HBlank) transfer and change destination after 1 transferred chunk.
; Write a different HDMA4.

EntryPoint:
    DisablePPU

    ; Copy data to WRAM2
    Memcpy $D000, VramData, VramDataEnd - VramData

    ; Set VRAM data
    Memset $8000, $ab, $60
    Memset $8400, $cd, $60

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

    ; Wait an HBlank
    Nops 114

    ; Dest address = 8400
    ld a, $0F
    ldh [rHDMA4], a

    ; Bit 7 = 1 (HBlank)
    ; Length = 64 bytes / $10 - 1 => 3
    ld a, $83
    ; ldh [rHDMA5], a

    ; Wait for enough HBlanks for transfer to happen
    ; (no precise timing check)
    Nops 5 * 114

    ; Disable PPU
    DisablePPU

    ; 3 chunk should have been transferred to 8000 from D010
    Memcmp $8000, VramData + $10, $30
    jp nz, TestFail

    Memtest $8030, $ab, $30
    jp nz, TestFail

    Memtest $8400, $cd, $60
    jp nz, TestFail

    jp TestSuccess

VramData:
    db $00, $11, $22, $33, $44, $55, $66, $77
    db $88, $99, $aa, $bb, $cc, $dd, $ee, $ff
    db $11, $22, $33, $44, $55, $66, $77, $88
    db $99, $aa, $bb, $cc, $dd, $ee, $ff, $00
    db $22, $33, $44, $55, $66, $77, $88, $99
    db $aa, $bb, $cc, $dd, $ee, $ff, $00, $11
    db $33, $44, $55, $66, $77, $88, $99, $aa
    db $bb, $cc, $dd, $ee, $ff, $00, $11, $22
    db $44, $55, $66, $77, $88, $99, $aa, $bb
    db $cc, $dd, $ee, $ff, $00, $11, $22, $33
VramDataEnd: