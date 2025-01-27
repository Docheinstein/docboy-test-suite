INCLUDE "docboy.inc"

; Check how Not Usable area behaves when writing and reading back something.

EntryPoint:
    DisablePPU

    Memset $fea0, $00, 96

    ; Copy some data to Not Usable
    Memcpy $fea0, Data, DataEnd - Data
    DumpMemory $fea0, 96

    ; Read entire area back
    Memcmp $fea0, ExpectedData, ExpectedDataEnd - ExpectedData

    jp nz, TestFail
    jp TestSuccess

Data:
    db $00, $01, $02, $03, $04, $05, $06, $07
    db $08, $09, $0a, $0b, $0c, $0d, $0e, $0f
    db $10, $11, $12, $13, $14, $15, $16, $17
    db $18, $19, $1a, $1b, $1c, $1d, $1e, $1f
    db $20, $21, $22, $23, $24, $25, $26, $27
    db $28, $29, $2a, $2b, $2c, $2d, $2e, $2f
    db $30, $31, $32, $33, $34, $35, $36, $37
    db $38, $39, $3a, $3b, $3c, $3d, $3e, $3f
    db $40, $41, $42, $43, $44, $45, $46, $47
    db $48, $49, $4a, $4b, $4c, $4d, $4e, $4f
    db $50, $51, $52, $53, $54, $55, $56, $57
    db $58, $59, $5a, $5b, $5c, $5d, $5e, $5f
DataEnd:

ExpectedData:
    db $00, $01, $02, $03, $04, $05, $06, $07
    db $08, $09, $0a, $0b, $0c, $0d, $0e, $0f
    db $10, $11, $12, $13, $14, $15, $16, $17
    db $18, $19, $1a, $1b, $1c, $1d, $1e, $1f
    db $50, $51, $52, $53, $54, $55, $56, $57
    db $58, $59, $5a, $5b, $5c, $5d, $5e, $5f
    db $50, $51, $52, $53, $54, $55, $56, $57
    db $58, $59, $5a, $5b, $5c, $5d, $5e, $5f
    db $50, $51, $52, $53, $54, $55, $56, $57
    db $58, $59, $5a, $5b, $5c, $5d, $5e, $5f
    db $50, $51, $52, $53, $54, $55, $56, $57
    db $58, $59, $5a, $5b, $5c, $5d, $5e, $5f
ExpectedDataEnd: