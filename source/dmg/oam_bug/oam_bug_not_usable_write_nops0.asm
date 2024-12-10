INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "dma.inc"

; Check the content of OAM after a write to Not Usable area is issued while PPU is in OAM Scan.

EntryPoint:
    DisablePPU

    ; Copy random data to DMA source (WRAM1 : c000)
    Memcpy $c000, RandomData, RandomDataEnd - RandomData

    DmaTransfer $c0

    EnablePPU

    ; Skip the first scanline: it behaves differently
    Nops 114
    
    ; Add some delay
    Nops 0

    ; Write something to OAM (FE00)
    ld a, $10
    ld hl, $fea0
    ld [hl], a

    ; Disable PPU to read OAM safely
    DisablePPU

    ; Compute checksum of OAM
    Checksum $fe00, 160

    ; Check result
    ld b, $3f
    cp b
    jp nz, TestFail

    jp TestSuccess


RandomData:
; fe00
db $a3, $6e, $78, $87, $8e, $26, $50, $ea,
db $ac, $c6, $a7, $a7, $47, $39, $f6, $ad,
db $c1, $fc, $13, $73, $41, $c1, $98, $28,
db $05, $3c, $ce, $90, $19, $de, $85, $27,

; fe20
db $46, $3e, $59, $64, $7d, $7a, $15, $72,
db $f3, $58, $94, $42, $cd, $37, $15, $b9,
db $02, $7c, $4e, $bd, $e0, $de, $2b, $c6,
db $e5, $4f, $66, $a0, $22, $28, $5c, $bc,

; fe40
db $4d, $fb, $00, $a0, $07, $34, $6a, $fc,
db $9b, $96, $9c, $35, $51, $1d, $ba, $4c,
db $83, $75, $4a, $4e, $ad, $b5, $c1, $71,
db $22, $18, $3e, $be, $3b, $07, $61, $25,

; fe60
db $3e, $74, $36, $e9, $3c, $d8, $1e, $50,
db $5f, $c5, $68, $91, $c1, $99, $32, $af,
db $d5, $4b, $01, $18, $14, $78, $31, $63,
db $4c, $1c, $a3, $77, $29, $49, $06, $75,

; fe80
db $ea, $8f, $ea, $d6, $56, $99, $2d, $d6,
db $7e, $7c, $4b, $9e, $59, $02, $09, $f3,
db $bf, $38, $c5, $9c, $bf, $f6, $a8, $8d,
db $b2, $a4, $8b, $49, $7f, $d5, $bb, $61,
RandomDataEnd:
