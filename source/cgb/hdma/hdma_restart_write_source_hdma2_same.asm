INCLUDE "all.inc"

; Perform a HDMA (HBlank) transfer and restart it after 1 transferred chunk.
; Write the same HDMA2.

EntryPoint:
    DisablePPU

    ; Copy data to WRAM2
    Memcpy $D000, VramData, VramDataEnd - VramData

    ; Set VRAM data
    Memset $8000, $ab, $60

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

    ; Source address = D00F
    ld a, $00
    ldh [rHDMA2], a

    ; Bit 7 = 1 (HBlank)
    ; Length = 64 bytes / $10 - 1 => 3
    ld a, $83
    ldh [rHDMA5], a

    ; Wait for enough HBlanks for transfer to happen
    ; (no precise timing check)
    Nops 5 * 114

    ; Disable PPU
    DisablePPU

    ; 1 chunk should have been transferred from D000
    Memcmp $8000, VramData, $10
    jp nz, TestFail

    ; 4 chunks should have been transferred from D000
    Memcmp $8010, VramData, $40
    jp nz, TestFail

    Memtest $8050, $ab, $10
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

VramData2:
    db $01, $12, $23, $34, $45, $56, $67, $78
    db $89, $9a, $ab, $bc, $cd, $de, $ef, $f0
    db $12, $23, $34, $45, $56, $67, $78, $89
    db $9a, $ab, $bc, $cd, $de, $ef, $f0, $12
    db $23, $34, $45, $56, $67, $78, $89, $9a
    db $ab, $bc, $cd, $de, $ef, $f0, $12, $23
    db $34, $45, $56, $67, $78, $89, $9a, $ab
    db $bc, $cd, $de, $ef, $f0, $12, $23, $34
    db $45, $56, $67, $78, $89, $9a, $ab, $bc
    db $cd, $de, $ef, $f0, $12, $23, $34, $45
VramData2End: