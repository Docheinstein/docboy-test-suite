INCLUDE "all.inc"

; HRAM generally has random data, but the end of HRAM that is used for the function callstack is deterministic.
; FFFE seems to be hardcoded to 4C even before boot rom.

EntryPoint:
    Memcmp $fffa, ExpectedFFFAData, ExpectedFFFADataEnd - ExpectedFFFAData
    jp nz, TestFail
    jp TestSuccess

ExpectedFFFAData:
    db $39, $01, $2e, $00, $4C
ExpectedFFFADataEnd: