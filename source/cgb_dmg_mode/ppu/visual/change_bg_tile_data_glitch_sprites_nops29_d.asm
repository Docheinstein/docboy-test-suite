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
    ld a, %10101010
    ldh [rOBP0], a
    ldh [rOBP1], a

    ; Write BGP
    ld a, %00011011
    ldh [rBGP], a

    ; Reset OAM
    Memset $fe00, $00, 160

    ; Copy OAM data
    Memcpy $fe00, OamData, OamDataEnd - OamData

    ; Set VRAM data
    ; 8000 with 00
    Memset $8000, $00, 16 * 16

    ; 9000 with FF
    Memset $9000, $ff, 16 * 16

    ; Background tile map
    Memcpy $9800, BackgroundTileMapData, BackgroundTileMapDataEnd - BackgroundTileMapData

    ; Copy ASCII tilemap to VRAM $9000 area.
    Memcpy $8190, CopyrightSign, CopyrightSignEnd - CopyrightSign

    ld a, LCDCF_ON | LCDCF_BGON | LCDCF_OBJON | LCDCF_BG9800 | LCDCF_BG8800 ; Reset
	ldh [rLCDC], a

    ; DumpMemory $8180, $80

    ei

Loop:
    Wait 8 * 114

DEF NUM_NOPS EQU 29
DEF NUM_NOPS_IN_BEETWEN EQU 2

REPT 128
    Nops NUM_NOPS

    ld a, LCDCF_ON | LCDCF_BGON | LCDCF_OBJON | LCDCF_BG9800 | LCDCF_BG8000 ; Set
    ldh [rLCDC], a

	Nops NUM_NOPS_IN_BEETWEN

	ld a, LCDCF_ON | LCDCF_BGON | LCDCF_OBJON | LCDCF_BG9800 | LCDCF_BG8800 ; Reset
    ldh [rLCDC], a

    Nops (114 - NUM_NOPS - NUM_NOPS_IN_BEETWEN - 10)
ENDR

    halt

    Wait 114 * 10 - 18

    jp Loop

    jp TestFail


BackgroundTileMapData:
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

OamData:
    DB $10, 00, $19, 0
    DB $18, 01, $19, 0
    DB $20, 02, $19, 0
    DB $28, 03, $19, 0
    DB $30, 04, $19, 0
    DB $38, 05, $19, 0
    DB $40, 06, $19, 0
    DB $48, 07, $19, 0
    DB $50, 08, $19, 0
    DB $58, 09, $19, 0
    DB $60, 10, $19, 0
    DB $68, 11, $19, 0
    DB $70, 12, $19, 0
    DB $78, 13, $19, 0
    DB $80, 14, $19, 0
    DB $88, 15, $19, 0
    DB $90, 16, $19, 0
    DB $98, 17, $19, 0
OamDataEnd:

CopyrightSign:
db $00, $3c, $00, $42, $00, $b9, $00, $a5, $00, $b9, $00, $a5, $00, $42, $00, $3c
CopyrightSignEnd:

SECTION "VBlank handler", ROM0[$40]
    reti

