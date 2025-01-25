INCLUDE "hardware.inc"
INCLUDE "common.inc"

EntryPoint:
    DisablePPU

    ; Copy data to OAM
    Memcpy $fe00, Data, DataEnd - Data

	ld a, LCDCF_ON | LCDCF_BGON
	ldh [rLCDC], a

    ; Skip the first scanline
    Nops 102

	Nops 22
	
    ; Write something to OAM
    ld bc, $0000
    ld sp, $fe45
    pop bc

    ; Disable PPU to read OAM safely
    DisablePPU

    ; Restore SP
    ld sp, $fffe

    ; Compare OAM
    Memcmp $fe00, ExpectedData, ExpectedDataEnd - ExpectedData

    jp nz, TestFail
    jp TestSuccess

Data:
; fe00
db $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $00, $00, $00, $00, $00, $00

; fe20
db $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $00, $00, $00, $00, $00, $00

; fe40
db $0f, $0f, $0f, $0f, $0f, $0f, $0f, $0f,
db $0f, $0f, $0f, $0f, $0f, $0f, $0f, $0f,
db $0f, $0f, $0f, $0f, $0f, $0f, $0f, $0f,
db $0f, $0f, $0f, $0f, $0f, $0f, $0f, $0f,

; fe60
db $0f, $0f, $0f, $0f, $0f, $0f, $0f, $0f,
db $0f, $0f, $0f, $0f, $0f, $0f, $0f, $0f,
db $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $00, $00, $00, $00, $00, $00

; fe80
db $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $00, $00, $00, $00, $00, $00
db $33, $55, $55, $33, $33, $55, $55, $33
db $00, $00, $00, $00, $00, $00, $00, $00
DataEnd:

ExpectedData:
; fe00
db $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $00, $00, $00, $00, $00, $00

; fe20
db $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $00, $00, $00, $00, $00, $00

; fe40
db $33, $55, $55, $33, $33, $55, $57, $37
db $0f, $0f, $0f, $0f, $0f, $0f, $0f, $0f,
db $0f, $0f, $0f, $0f, $0f, $0f, $0f, $0f,
db $0f, $0f, $0f, $0f, $0f, $0f, $0f, $0f,

; fe60
db $0f, $0f, $0f, $0f, $0f, $0f, $0f, $0f,
db $0f, $0f, $0f, $0f, $0f, $0f, $0f, $0f,
db $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $00, $00, $00, $00, $00, $00

; fe80
db $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $00, $00, $00, $00, $00, $00
db $33, $55, $55, $33, $33, $55, $55, $33
db $33, $55, $55, $33, $33, $55, $57, $37
ExpectedDataEnd:
