INCLUDE "all.inc"

; Change LCDC BG tile data during pixel transfer with sprites at various X and check for CGB BG/WIN tile data change glitch.

EntryPoint:
    DisablePPU

    ; Set SCX=0
    ld a, $00
    ldh [rSCX], a

    ; Enable VBlank interrupt
    xor a
    ldh [rIF], a

    ld a, $01
    ldh [rIE], a

    ; Write OBJ palette
    ld a, %01010101
    ldh [rOBP0], a
    ldh [rOBP1], a

    ; Write BGP
    ld a, %11100100
    ldh [rBGP], a

    ; Reset OAM
    Memset $fe00, $00, 160

    ; Reset VRAM
    Memset $8000, $00, $2000

    ; Set VRAM data
    ; 8000 with FF
    Memset $8000, $FF, $800

    ; 9000 with FF
    Memset $9000, $00, $800

    ; Background tile map
    Memcpy $9800, BackgroundTileMapData, BackgroundTileMapDataEnd - BackgroundTileMapData

    ; 8000 with 00
    Memcpy $80F0, FunnyTile, 16

    ld a, LCDCF_ON | LCDCF_BGON | LCDCF_OBJON | LCDCF_BG9800 | LCDCF_BG8800 ; Reset
	ldh [rLCDC], a

    ei

Loop:
DEF NUM_NOPS EQU 29
DEF NUM_NOPS_IN_BEETWEN EQU 2

Wait 24 * 114

REPT 143 - 24
    Nops NUM_NOPS

    ld a, LCDCF_ON | LCDCF_BGON | LCDCF_OBJON | LCDCF_BG9800 | LCDCF_BG8000 ; Set
    ldh [rLCDC], a

	Nops NUM_NOPS_IN_BEETWEN

	ld a, LCDCF_ON | LCDCF_BGON | LCDCF_OBJON | LCDCF_BG9800 | LCDCF_BG8800 ; Reset
    ldh [rLCDC], a

    Nops (114 - NUM_NOPS - NUM_NOPS_IN_BEETWEN - 10)
ENDR

; Line 144

DEF LAST_LINE_EXTRA_NOPS EQU 17

    Nops NUM_NOPS

    ld a, LCDCF_ON | LCDCF_BGON | LCDCF_OBJON | LCDCF_BG9800 | LCDCF_BG8000 ; Set
    ldh [rLCDC], a

	Nops 62 + LAST_LINE_EXTRA_NOPS

	ld a, LCDCF_ON | LCDCF_BGON | LCDCF_OBJON | LCDCF_BG9800 | LCDCF_BG8800 ; Reset
    ldh [rLCDC], a


    Wait 114 * 10 - LAST_LINE_EXTRA_NOPS

    jp Loop

    jp TestFail




BackgroundTileMapData:
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00

    db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01
    db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01

    db $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02
    db $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02, $02

    db $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03
    db $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03, $03

    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04
    db $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04, $04

    db $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05
    db $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05, $05

    db $06, $06, $06, $06, $06, $06, $06, $06, $06, $06, $06, $06, $06, $06, $06, $06
    db $06, $06, $06, $06, $06, $06, $06, $06, $06, $06, $06, $06, $06, $06, $06, $06

    db $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07
    db $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07, $07

    db $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08
    db $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08, $08

    db $09, $09, $09, $09, $09, $09, $09, $09, $09, $09, $09, $09, $09, $09, $09, $09
    db $09, $09, $09, $09, $09, $09, $09, $09, $09, $09, $09, $09, $09, $09, $09, $09

    db $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A
    db $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A, $0A

    db $0B, $0B, $0B, $0B, $0B, $0B, $0B, $0B, $0B, $0B, $0B, $0B, $0B, $0B, $0B, $0B
    db $0B, $0B, $0B, $0B, $0B, $0B, $0B, $0B, $0B, $0B, $0B, $0B, $0B, $0B, $0B, $0B

    db $0C, $0C, $0C, $0C, $0C, $0C, $0C, $0C, $0C, $0C, $0C, $0C, $0C, $0C, $0C, $0C
    db $0C, $0C, $0C, $0C, $0C, $0C, $0C, $0C, $0C, $0C, $0C, $0C, $0C, $0C, $0C, $0C

    db $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0D
    db $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0D, $0D

    db $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E
    db $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E, $0E

    db $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
    db $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F, $0F
BackgroundTileMapDataEnd:

FunnyTile:
db $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $FF, $C3, $C3, $F3, $F3,

SECTION "VBlank handler", ROM0[$40]
    reti
