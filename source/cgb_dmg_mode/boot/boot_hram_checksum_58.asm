;! TITLE=SIMULATIONS
;! OLD_LICENSE=1

INCLUDE "all.inc"

; HRAM generally has random data, but the start and end of HRAM is deterministic.
; FFFE seems to be hardcoded to C0 even before boot rom.

EntryPoint:
    Memcmp $ff80, ExpectedFF80Data, ExpectedFF80DataEnd - ExpectedFF80Data
    jp nz, TestFail

    Memcmp $fff2, ExpectedFFF2Data, ExpectedFFF2DataEnd - ExpectedFFF2Data
    jp nz, TestFail

    jp TestSuccess

ExpectedFF80Data:
    db $CE, $ED, $66, $66, $CC, $0D, $00, $0B,
    db $03, $73, $00, $83, $00, $0C, $00, $0D,
    db $00, $08, $11, $1F, $88, $89, $00, $0E,
    db $DC, $CC, $6E, $E6, $DD, $DD, $D9, $99,
    db $BB, $BB, $67, $63, $6E, $0E, $EC, $CC,
    db $DD, $DC, $99, $9F, $BB, $B9, $33, $3E,
ExpectedFF80DataEnd:


ExpectedFFF2Data:
    db           $71, $02, $4D, $01, $00, $FF,
    db $0D, $00, $03, $06, $F9, $00, $C0
ExpectedFFF2DataEnd: