INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "cgb.inc"

; Check how Not Usable area behaves when writing and reading back something.

EntryPoint:
    DisablePPU

    Memset $fea0, $00, 96

    ; Copy some data to FEE0
    Memcpy $fee0, Data, DataEnd - Data

    ; Read entire area back
    Memcmp $fea0, ExpectedData, ExpectedDataEnd - ExpectedData

    jp nz, TestFailCGB
    jp TestSuccessCGB

Data:
    db $00, $01, $02, $03, $04, $05, $06, $07
    db $08, $09, $0a, $0b, $0c, $0d, $0e, $0f
DataEnd:

ExpectedData:
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $01, $02, $03, $04, $05, $06, $07
    db $08, $09, $0a, $0b, $0c, $0d, $0e, $0f
    db $00, $01, $02, $03, $04, $05, $06, $07
    db $08, $09, $0a, $0b, $0c, $0d, $0e, $0f
    db $00, $01, $02, $03, $04, $05, $06, $07
    db $08, $09, $0a, $0b, $0c, $0d, $0e, $0f
    db $00, $01, $02, $03, $04, $05, $06, $07
    db $08, $09, $0a, $0b, $0c, $0d, $0e, $0f
ExpectedDataEnd:
