INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "dma.inc"
INCLUDE "cgb.inc"


; Perform a HDMA (General Purpose) transfer with PPU on during Pixel Transfer.
; Check the data after the transfer.

EntryPoint:
    DisablePPU

    ; Set OAM Data
    ResetOAM
    Memcpy $fe00, OamData, OamDataEnd - OamData

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
    EnablePPU

    ; Skip glitched line 0
    Nops 110

    ; Bit 7 = 0 (general purpose)
    ; Length = 80 bytes / $10 - 1 => 4
    ld a, $04

    ldh [rHDMA5], a

    ; --- transfer happens here ---

    DisablePPU

    Memcmp $8000 + ExpectedVramDataIgnoreWrite - ExpectedVramData, ExpectedVramDataIgnoreWrite, ExpectedVramDataEnd - ExpectedVramDataIgnoreWrite

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
    db $77, $88, $55, $33, $44, $55, $66, $77
    db $88, $99, $aa, $bb, $cc, $dd, $ee, $ff
ExpectedVramDataIgnoreWrite:
    db $11, $22, $33, $44, $55, $66, $77, $88
    db $99, $aa, $bb, $cc, $dd, $ee, $ff, $00
    db $22, $33, $44, $55, $ab, $ab, $ab, $99
    db $ab, $ab, $ab, $dd, $ab, $ab, $00, $11
    db $ab, $ab, $ab, $66, $ab, $ab, $99, $aa
    db $bb, $ab, $ab, $ab, $ff, $ab, $ab, $ab
    db $44, $ab, $ab, $ab, $88, $ab, $ab, $ab
    db $cc, $ab, $ab, $ab, $00, $ab, $ab, $ab
    db $ab, $ab, $ab, $ab, $ab, $ab, $ab, $ab
    db $ab, $ab, $ab, $ab, $ab, $ab, $ab, $ab
    db $ab, $ab, $ab, $ab, $ab, $ab, $ab, $ab
    db $ab, $ab, $ab, $ab, $ab, $ab, $ab, $ab
    db $ab, $ab, $ab, $ab, $ab, $ab, $ab, $ab
    db $ab, $ab, $ab, $ab, $ab, $ab, $ab, $ab
ExpectedVramDataEnd:


OamData:
    db $10, 10, $00, $00
    db $10, 18, $00, $00
OamDataEnd: