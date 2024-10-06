INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Reading from OAM during Pixel Transfer should read FF.

EntryPoint:
    WaitVBlank

    ; Copy some data to OAM (fe00)
    Memset $fe00, $01, $4

    WaitScanline $01

    ; Wait until Pixel Transfer
    Nops 4

    ; Copy back from OAM to WRAM1 (c000)
    Memcpy $c000, $fe00, $4

    ; Compare with expected result
    Memcmp $c000, ExpectedData, ExpectedDataEnd - ExpectedData
    jp nz, TestFail

    jp TestSuccess

ExpectedData:
db $ff, $ff, $ff, $01
ExpectedDataEnd: