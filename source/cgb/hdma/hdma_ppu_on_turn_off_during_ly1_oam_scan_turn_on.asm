INCLUDE "all.inc"

; Perform a HDMA (HBlank) transfer with PPU on, then turn it off during LY=1 OAM Scan, and then turn it on again.
; Check that data is transferred.

EntryPoint:
    DisablePPU

    ; Set VRAM data
    Memset $8000, $ab, $80

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

    EnablePPU

    ; Bit 7 = 1 (HBlank)
    ; Length = 64 bytes / $10 - 1 => 3
    ld a, $83
    ldh [rHDMA5], a

    ; --- transfer happens here ---

    ; Wait for LY=1 OamScan
    Nops 100

    DisablePPU

    ; Wait for enough HBlanks to happen
    ; (no precise timing check)
    Nops 4 * 114

    EnablePPU

    ; Wait for enough HBlanks to happen
    ; (no precise timing check)
    Nops 4 * 114

    DisablePPU

    Memcmp $8000, ExpectedVramData, ExpectedVramDataEnd - ExpectedVramData
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
VramDataEnd:

ExpectedVramData:
    db $00, $11, $22, $33, $44, $55, $66, $77
    db $88, $99, $aa, $bb, $cc, $dd, $ee, $ff
    db $11, $22, $33, $44, $55, $66, $77, $88
    db $99, $aa, $bb, $cc, $dd, $ee, $ff, $00
    db $22, $33, $44, $55, $66, $77, $88, $99
    db $aa, $bb, $cc, $dd, $ee, $ff, $00, $11
    db $33, $44, $55, $66, $77, $88, $99, $aa
    db $bb, $cc, $dd, $ee, $ff, $00, $11, $22
    db $ab, $ab, $ab, $ab, $ab, $ab, $ab, $ab
    db $ab, $ab, $ab, $ab, $ab, $ab, $ab, $ab
ExpectedVramDataEnd: