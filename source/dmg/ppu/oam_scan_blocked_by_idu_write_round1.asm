INCLUDE "all.inc"

; Check that when IDU submit an address on the address bus (see OAM BUG)
; prevents PPU to read from OAM at the proper address.

EntryPoint:
    DisablePPU

    ; Copy data to OAM
    Memcpy $fe00, Data, DataEnd - Data

	EnablePPU_WithSprites

    ; Skip the first scanline
    Nops 103

	Nops 8
	
    ; Write something to OAM
    ld a, $00
    ld hl, $fe40
    inc hl

    Nops 56

    ld a, [rSTAT]
    cp $83

    jp nz, TestFail
    jp TestSuccess

Data:
; fe00
db $00, $00, $00, $00
db $00, $00, $00, $00
db $00, $00, $00, $00
db $00, $00, $00, $00
db $00, $00, $00, $00
db $00, $00, $00, $00
db $00, $00, $00, $00
db $00, $00, $00, $00

; fe20
db $00, $00, $00, $00
db $10, $20, $00, $00
db $00, $00, $00, $00
db $00, $00, $00, $00
db $00, $00, $00, $00
db $00, $00, $00, $00
db $00, $00, $00, $00
db $00, $00, $00, $00

; fe40
db $00, $00, $00, $00
db $00, $00, $00, $00
db $00, $00, $00, $00
db $00, $00, $00, $00
db $00, $00, $00, $00
db $00, $00, $00, $00
db $00, $00, $00, $00
db $00, $00, $00, $00

; fe60
db $00, $00, $00, $00
db $00, $00, $00, $00
db $00, $00, $00, $00
db $00, $00, $00, $00
db $00, $00, $00, $00
db $00, $00, $00, $00
db $00, $00, $00, $00
db $00, $00, $00, $00

; fe80
db $00, $00, $00, $00
db $00, $00, $00, $00
db $00, $00, $00, $00
db $00, $00, $00, $00
db $00, $00, $00, $00
db $00, $00, $00, $00
db $00, $00, $00, $00
db $00, $00, $00, $00
DataEnd:
