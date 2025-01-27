INCLUDE "docboy.inc"

; Check how Not Usable area behaves when writing and reading back something.

EntryPoint:
    DisablePPU

    Memset $fea0, $00, 96

    ; Copy some data to FEB0
    Memcpy $feb0, Data, DataEnd - Data

    ; Read entire area back
    Memcmp $fea0, ExpectedData, ExpectedDataEnd - ExpectedData

    jp nz, TestFail
    jp TestSuccess

Data:
    db $00, $01, $02, $03, $04, $05, $06, $07
    db $08, $09, $0a, $0b, $0c, $0d, $0e, $0f
DataEnd:

ExpectedData:
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $01, $02, $03, $04, $05, $06, $07
    db $08, $09, $0a, $0b, $0c, $0d, $0e, $0f
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
ExpectedDataEnd:
