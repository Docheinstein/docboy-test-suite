INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Reading from VRAM during Pixel Transfer should read FF.

EntryPoint:
    WaitVBlank

    ; Copy some data to VRAM (8000)
    Memset $8000, $01, $4

    WaitScanline $01

    ; Wait until Pixel Transfer
    Nops 4

    ; Copy back from VRAM to WRAM1 (c000)
    Memcpy $c000, $8000, $4

    ; Compare with expected result
    Memcmp $c000, ExpectedData, ExpectedDataEnd - ExpectedData
    jp nz, TestFail

    jp TestSuccess

ExpectedData:
db $ff, $ff, $ff, $01
ExpectedDataEnd: