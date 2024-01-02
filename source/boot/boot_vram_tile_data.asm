INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Check VRAM content after boot.

EntryPoint:
    ; Disable PPU to safely access VRAM
    DisablePPU

    ; Compare with expected result
    Memcmp $8000, VramTileData, VramTileDataEnd - VramTileData
    jp nz, TestFail

    jp TestSuccess

VramTileData:
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $f0, $00, $f0, $00, $fc, $00, $fc, $00, $fc, $00, $fc, $00, $f3, $00, $f3, $00
    db $3c, $00, $3c, $00, $3c, $00, $3c, $00, $3c, $00, $3c, $00, $3c, $00, $3c, $00
    db $f0, $00, $f0, $00, $f0, $00, $f0, $00, $00, $00, $00, $00, $f3, $00, $f3, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $cf, $00, $cf, $00
    db $00, $00, $00, $00, $0f, $00, $0f, $00, $3f, $00, $3f, $00, $0f, $00, $0f, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $c0, $00, $c0, $00, $0f, $00, $0f, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $f0, $00, $f0, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $f3, $00, $f3, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $c0, $00, $c0, $00
    db $03, $00, $03, $00, $03, $00, $03, $00, $03, $00, $03, $00, $ff, $00, $ff, $00
    db $c0, $00, $c0, $00, $c0, $00, $c0, $00, $c0, $00, $c0, $00, $c3, $00, $c3, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $fc, $00, $fc, $00
    db $f3, $00, $f3, $00, $f0, $00, $f0, $00, $f0, $00, $f0, $00, $f0, $00, $f0, $00
    db $3c, $00, $3c, $00, $fc, $00, $fc, $00, $fc, $00, $fc, $00, $3c, $00, $3c, $00
    db $f3, $00, $f3, $00, $f3, $00, $f3, $00, $f3, $00, $f3, $00, $f3, $00, $f3, $00
    db $f3, $00, $f3, $00, $c3, $00, $c3, $00, $c3, $00, $c3, $00, $c3, $00, $c3, $00
    db $cf, $00, $cf, $00, $cf, $00, $cf, $00, $cf, $00, $cf, $00, $cf, $00, $cf, $00
    db $3c, $00, $3c, $00, $3f, $00, $3f, $00, $3c, $00, $3c, $00, $0f, $00, $0f, $00
    db $3c, $00, $3c, $00, $fc, $00, $fc, $00, $00, $00, $00, $00, $fc, $00, $fc, $00
    db $fc, $00, $fc, $00, $f0, $00, $f0, $00, $f0, $00, $f0, $00, $f0, $00, $f0, $00
    db $f3, $00, $f3, $00, $f3, $00, $f3, $00, $f3, $00, $f3, $00, $f0, $00, $f0, $00
    db $c3, $00, $c3, $00, $c3, $00, $c3, $00, $c3, $00, $c3, $00, $ff, $00, $ff, $00
    db $cf, $00, $cf, $00, $cf, $00, $cf, $00, $cf, $00, $cf, $00, $c3, $00, $c3, $00
    db $0f, $00, $0f, $00, $0f, $00, $0f, $00, $0f, $00, $0f, $00, $fc, $00, $fc, $00
    db $3c, $00, $42, $00, $b9, $00, $a5, $00, $b9, $00, $a5, $00, $42, $00, $3c, $00
VramTileDataEnd:
