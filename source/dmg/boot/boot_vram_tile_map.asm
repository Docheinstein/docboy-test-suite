INCLUDE "all.inc"

; Check VRAM content after boot.

EntryPoint:
    ; Disable PPU to safely access VRAM
    DisablePPU

    ; Compare with expected result
    Memcmp $9900, VramTileMapData, VramTileMapDataEnd - VramTileMapData
    jp nz, TestFail

    jp TestSuccess

VramTileMapData:
    db $00, $00, $00, $00, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0a, $0b, $0c
    db $19, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $0d, $0e, $0f, $10, $11, $12, $13, $14, $15, $16, $17, $18
VramTileMapDataEnd:

