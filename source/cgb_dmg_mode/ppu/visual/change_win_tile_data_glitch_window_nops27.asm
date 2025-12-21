INCLUDE "all.inc"

; Change LCDC BG tile data during pixel transfer with window at various WX and check for CGB BG/WIN tile data change glitch.

EntryPoint:
    DisablePPU

    ; Set WY
    ld a, 8
    ldh [rWY], a

    ; Set WX=16
    ld a, 16
    ldh [rWX], a

    ; Set SCX=0
    ld a, $00
    ldh [rSCX], a

    ; Enable VBlank interrupt
    xor a
    ldh [rIF], a

    ld a, $01
    ldh [rIE], a

    ; Write BGP
    ld a, %11100100
    ldh [rBGP], a

    ; Reset VRAM
    Memset $8000, $00, $2000

    ; Set VRAM data
    ; 8000 with 00
    Memset $8000, $00, $800

    ; 9000 with FF
    Memset $9000, $ff, $800

    ; Background tile map
    Memcpy $9800, BackgroundTileMapData, BackgroundTileMapDataEnd - BackgroundTileMapData

    ; Copy ASCII tilemap to VRAM $9000 area.
    Memcpy $8800, AsciiTilemap + 88 * 16, 16

    ld a, LCDCF_ON | LCDCF_BGON | LCDCF_WINON | LCDCF_BG9800 | LCDCF_WIN9800 | LCDCF_BG8800 ; Reset
	ldh [rLCDC], a

    ei

Loop:
    Wait 8 * 114

DEF NUM_NOPS EQU 27
DEF NUM_NOPS_IN_BEETWEN EQU 2

FOR I, 128
    ; Set WX=16, 17, 18, ... (change every 8 lines)
    ld a, 16 + I / 8
    ldh [rWX], a

    Nops NUM_NOPS - 5

    ld a, LCDCF_ON | LCDCF_BGON | LCDCF_WINON | LCDCF_BG9800 | LCDCF_WIN9800 | LCDCF_BG8000 ; Set
    ldh [rLCDC], a

	Nops NUM_NOPS_IN_BEETWEN

	ld a, LCDCF_ON | LCDCF_BGON | LCDCF_WINON | LCDCF_BG9800 | LCDCF_WIN9800 | LCDCF_BG8800 ; Reset
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

SECTION "VBlank handler", ROM0[$40]
    reti

