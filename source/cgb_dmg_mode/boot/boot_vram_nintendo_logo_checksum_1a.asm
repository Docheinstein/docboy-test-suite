Title "PROMOTIONS"
OldLicenseeCode $01

INCLUDE "all.inc"

; Check the content of VRAM at 9900: checksum $1A should NOT copy logo to this area.

EntryPoint:
    ; Disable PPU to safely access VRAM
    DisablePPU

    ; Compare with expected result
    Memcmp $9900, Vram9900Data, Vram9900DataEnd - Vram9900Data

    jp nz, TestFail
    jp TestSuccess

Vram9900Data:
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
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
Vram9900DataEnd:

