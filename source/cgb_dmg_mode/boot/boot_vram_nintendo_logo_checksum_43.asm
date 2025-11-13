Title "INVESTIGATE"
OldLicenseeCode $01

INCLUDE "all.inc"

; Check the content of VRAM at 9900: checksum $43 should NOT copy logo to this area.

EntryPoint:
    ; Disable PPU to safely access VRAM
    DisablePPU

    ; Compare with expected result
    Memcmp $9900, Vram9900Data, Vram9900DataEnd - Vram9900Data

    jp nz, TestFail
    jp TestSuccess

Vram9900Data:
    db $00, $00, $00, $00, $01, $02, $03, $04,
    db $05, $06, $07, $08, $09, $0A, $0B, $0C
    db $19, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $0D, $0E, $0F, $10
    db $11, $12, $13, $14, $15, $16, $17, $18
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
Vram9900DataEnd:

