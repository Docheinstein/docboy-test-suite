INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "cgb.inc"

; Perform a HDMA (General Purpose) transfer with PPU on during Pixel Transfer.
; Check that data is not transferred when the PPU reads VRAM.
; SCX=4

EntryPoint:
    DisablePPU

    ; Write SCX=4
    ld a, $04
    ldh [rSCX], a

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
    ; Length = 128 bytes / $10 - 1 => 7
    ld a, $07

Start:
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
    db $00, $11, $22, $33, $44, $55, $66, $77
    db $88, $99, $aa, $bb, $cc, $dd, $ee, $ff
ExpectedVramDataIgnoreWrite:
    db $11, $22, $33, $44, $55, $66, $77, $88
    db $99, $aa, $bb, $cc, $dd, $ee, $ff, $00
    db $22, $33, $44, $55, $ab, $ab, $ab, $99
    db $ab, $ab, $ab, $dd, $ab, $ab, $ab, $11
    db $ab, $ab, $ab, $66, $ab, $ab, $ab, $aa
    db $ab, $ab, $ab, $ee, $ab, $ab, $ab, $22
    db $ab, $ab, $ab, $77, $ab, $ab, $ab, $bb
    db $ab, $ab, $ab, $ff, $ab, $ab, $ab, $33
    db $ab, $ab, $ab, $88, $ab, $ab, $ab, $cc
    db $ab, $ab, $ab, $00, $ab, $ab, $ab, $44
    db $ab, $ab, $ab, $99, $ab, $ab, $ab, $dd
    db $ab, $ab, $ab, $11, $ab, $ab, $ab, $55
    db $ab, $ab, $ab, $aa, $ab, $ab, $ab, $ee
    db $ab, $ab, $11, $22, $33, $44, $55, $66
ExpectedVramDataEnd: