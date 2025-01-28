INCLUDE "all.inc"

; Check the OAM corruption pattern for a specific combination of instruction and CPU/PPU timing.

EntryPoint:
    DisablePPU

    ; Copy data to OAM
    Memcpy $fe00, Data, DataEnd - Data

	EnablePPU

    ; Skip the first scanline
    Nops 103

	Nops 14
	
    ; Write something to OAM
    ld a, $66
    ld hl, $fe61
    ld [hl], a

    ; Disable PPU to read OAM safely
    DisablePPU

    ; Compare OAM
    Memcmp $fe00, ExpectedData, ExpectedDataEnd - ExpectedData

    jp nz, TestFail
    jp TestSuccess

Data:
; fe00
db $cc, $87, $00, $00, $aa, $0f, $00, $01
db $f0, $4b, $01, $00, $55, $0f, $01, $01
db $33, $2d, $02, $00, $aa, $0f, $02, $01
db $0f, $1e, $03, $00, $55, $0f, $03, $01

; fe20
db $cc, $87, $04, $00, $aa, $0f, $04, $01
db $f0, $4b, $05, $00, $55, $0f, $05, $01
db $33, $2d, $06, $00, $aa, $0f, $06, $01
db $0f, $1e, $07, $00, $55, $0f, $07, $01

; fe40
db $cc, $87, $08, $00, $aa, $0f, $08, $01
db $f0, $4b, $09, $00, $55, $0f, $09, $01
db $33, $2d, $0a, $00, $aa, $0f, $0a, $01
db $0f, $1e, $0b, $00, $55, $0f, $0b, $01

; fe60
db $cc, $87, $0c, $00, $aa, $0f, $0c, $01
db $f0, $4b, $0d, $00, $55, $0f, $0d, $01
db $33, $2d, $0e, $00, $aa, $0f, $0e, $01
db $0f, $1e, $0f, $00, $55, $0f, $0f, $01

; fe80
db $cc, $87, $10, $00, $aa, $0f, $10, $01
db $f0, $4b, $11, $00, $55, $0f, $11, $01
db $33, $2d, $12, $00, $aa, $0f, $12, $01
db $0f, $1e, $13, $00, $55, $0f, $13, $01
DataEnd:

ExpectedData:
; fe00
db $cc, $87, $00, $00, $aa, $0f, $00, $01
db $f0, $4b, $01, $00, $55, $0f, $01, $01
db $33, $2d, $02, $00, $aa, $0f, $02, $01
db $0f, $1e, $03, $00, $55, $0f, $03, $01

; fe20
db $cc, $87, $04, $00, $aa, $0f, $04, $01
db $f0, $4b, $05, $00, $55, $0f, $05, $01
db $33, $2d, $06, $00, $aa, $0f, $06, $01
db $0f, $1e, $07, $00, $55, $0f, $07, $01

; fe40
db $cc, $87, $08, $00, $aa, $0f, $08, $01
db $f0, $4b, $09, $00, $55, $0f, $09, $01
db $33, $2d, $0a, $00, $aa, $0f, $0a, $01
db $2b, $0f, $0a, $00, $aa, $0f, $0a, $01

; fe60
db $cc, $87, $0c, $00, $aa, $0f, $0c, $01
db $f0, $4b, $0d, $00, $55, $0f, $0d, $01
db $33, $2d, $0e, $00, $aa, $0f, $0e, $01
db $0f, $1e, $0f, $00, $55, $0f, $0f, $01

; fe80
db $cc, $87, $10, $00, $aa, $0f, $10, $01
db $f0, $4b, $11, $00, $55, $0f, $11, $01
db $33, $2d, $12, $00, $aa, $0f, $12, $01
db $0f, $1e, $13, $00, $55, $0f, $13, $01
ExpectedDataEnd:
