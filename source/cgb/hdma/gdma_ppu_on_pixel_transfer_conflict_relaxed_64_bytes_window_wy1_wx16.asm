INCLUDE "all.inc"

; Perform a HDMA (General Purpose) transfer with PPU on during Pixel Transfer.
; Check the data after the transfer.

EntryPoint:
    DisablePPU

    ; Write WY=1
    ld a, $01
    ldh [rWY], a

    ; Write WX=16
    ld a, 16
    ldh [rWX], a

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

    ; Enable PPU
	ld a, LCDCF_ON | LCDCF_BGON | LCDCF_WINON
	ldh [rLCDC], a

    ; Skip glitched line 0
    Nops 110

    ; Bit 7 = 0 (general purpose)
    ; Length = 64 bytes / $10 - 1 => 3
    ld a, $03

    ldh [rHDMA5], a

    ; --- transfer happens here ---

    DisablePPU

    Memcmp $8000 + ExpectedVramDataIgnoreWrite - ExpectedVramData, ExpectedVramDataIgnoreWrite, ExpectedVramDataEnd - ExpectedVramDataIgnoreWrite

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
    db $55, $66, $77, $88, $99, $aa, $bb, $cc
    db $dd, $ee, $ff, $00, $11, $22, $33, $44
    db $66, $77, $88, $99, $aa, $bb, $cc, $dd
    db $ee, $ff, $00, $11, $22, $33, $44, $55
    db $77, $88, $99, $aa, $bb, $cc, $dd, $ee
    db $ff, $00, $11, $22, $33, $44, $55, $66
VramDataEnd:

ExpectedVramData:
    db $ff, $00, $66, $aa, $44, $22, $66, $77
    db $88, $99, $aa, $bb, $cc, $dd, $ee, $ff
ExpectedVramDataIgnoreWrite:
    db $11, $22, $33, $44, $55, $66, $77, $88
    db $99, $aa, $bb, $cc, $dd, $ee, $ff, $00
    db $22, $33, $44, $55, $ab, $ab, $ab, $99
    db $ab, $ab, $ab, $dd, $ab, $ab, $ab, $ab
    db $ab, $ab, $55, $ab, $ab, $ab, $99, $ab
    db $ab, $ab, $dd, $ab, $ab, $ab, $11, $ab
    db $ab, $ab, $ab, $ab, $ab, $ab, $ab, $ab
    db $ab, $ab, $ab, $ab, $ab, $ab, $ab, $ab
    db $ab, $ab, $ab, $ab, $ab, $ab, $ab, $ab
    db $ab, $ab, $ab, $ab, $ab, $ab, $ab, $ab
    db $ab, $ab, $ab, $ab, $ab, $ab, $ab, $ab
    db $ab, $ab, $ab, $ab, $ab, $ab, $ab, $ab
    db $ab, $ab, $ab, $ab, $ab, $ab, $ab, $ab
    db $ab, $ab, $ab, $ab, $ab, $ab, $ab, $ab
ExpectedVramDataEnd:

ExpectedVramDataNoWriteConflict:
    db $00, $11, $22, $33, $44, $55, $66, $77
    db $88, $99, $aa, $bb, $cc, $dd, $ee, $ff
    db $11, $22, $33, $44, $55, $66, $77, $88
    db $99, $aa, $bb, $cc, $dd, $ee, $ff, $00
    db $22, $33, $44, $55, $ab, $ab, $ab, $99
    db $ab, $ab, $ab, $dd, $ab, $ab, $ab, $ab
    db $ab, $ab, $55, $ab, $ab, $ab, $99, $ab
    db $ab, $ab, $dd, $ab, $ab, $ab, $11, $ab
    db $ab, $ab, $ab, $ab, $ab, $ab, $ab, $ab
    db $ab, $ab, $ab, $ab, $ab, $ab, $ab, $ab
    db $ab, $ab, $ab, $ab, $ab, $ab, $ab, $ab
    db $ab, $ab, $ab, $ab, $ab, $ab, $ab, $ab
    db $ab, $ab, $ab, $ab, $ab, $ab, $ab, $ab
    db $ab, $ab, $ab, $ab, $ab, $ab, $ab, $ab
    db $ab, $ab, $ab, $ab, $ab, $ab, $ab, $ab
    db $ab, $ab, $ab, $ab, $ab, $ab, $ab, $ab
ExpectedVramDataNoWriteConflictEnd: