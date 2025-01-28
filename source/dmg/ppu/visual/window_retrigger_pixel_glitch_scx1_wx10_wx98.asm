
INCLUDE "all.inc"

; Render with window enabled, wait for WX to trigger the window,
; than move WX ahead so that the window will encounter it again.

EntryPoint:
    ; Disable PPU
    DisablePPU

    ; Set BGP
    ld a, %11100100
    ldh [rBGP], a

    ; Set SCX
    ld a, 1
    ldh [rSCX], a
    
    ; Set WY
    ld a, 12
    ldh [rWY], a

    ; Reset VRAM
    ; Reset VRAM
    Memset $8000, $00, $2000

    ; Set Window VRAM data
    Memcpy $9010, WindowVramTileData, WindowVramTileDataEnd - WindowVramTileData
    Memcpy $9C00, WindowVramTileMapData, WindowVramTileMapDataEnd - WindowVramTileMapData

    ; Set BG VRAM data
    Memcpy $8800, BackgroundVramTileData, BackgroundVramTileDataEnd - BackgroundVramTileData
    Memcpy $9800, BackgroundVramTileMapData, BackgroundVramTileMapDataEnd - BackgroundVramTileMapData

Loop:
    ; Adjust phase to avoid flickr.
    Nops 3

    ; Set WX=10
    ld a, 10
    ldh [rWX], a

    ; Enable window
    ld a, LCDCF_ON | LCDCF_BGON | LCDCF_WINON | LCDCF_WIN9C00
    ldh [rLCDC], a

    WaitScanline 12

    ; Wait so that a part of the window is render.
    Nops 16

    ; Set WX=98
    ld a, 98
    ldh [rWX], a

    ; Wait HBlank
    WaitMode 0

    ; Disable window
    ld a, LCDCF_ON | LCDCF_BGON | LCDCF_WIN9C00
    ldh [rLCDC], a

    WaitVBlank

    jp Loop


WindowVramTileData:
    db $ff, $80, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00
    db $ff, $80, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00
    db $ff, $80, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00
    db $ff, $80, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00
    db $ff, $80, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00
    db $ff, $80, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00
    db $ff, $80, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00
    db $ff, $80, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00
    db $ff, $80, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00
    db $ff, $80, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00
    db $ff, $80, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00
    db $ff, $80, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00
    db $ff, $80, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00
    db $ff, $80, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00
    db $ff, $80, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00
    db $ff, $80, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00
    db $ff, $80, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00
    db $ff, $80, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00
    db $ff, $80, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00
    db $ff, $80, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00
WindowVramTileDataEnd:


WindowVramTileMapData:
    db $01, $02, $03, $04, $05, $06, $07, $08, $09, $0a, $0b, $0c, $0d, $0e, $0f, $10,
    db $11, $12, $13, $14, $15, $16, $17, $18, $19
WindowVramTileMapDataEnd:


BackgroundVramTileData:
    ; First row
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff


    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff

    ; Second row
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff


    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff

    ; Third row
    db $ff, $7f, $ff, $7f, $ff, $7f, $7f, $7f, $ff, $7f, $ff, $7f, $ff, $7f, $ff, $7f,
    db $ff, $7e, $ff, $7e, $ff, $7e, $7f, $7e, $ff, $7e, $ff, $7e, $ff, $7e, $ff, $7e,
    db $ff, $7d, $ff, $7d, $ff, $7d, $7f, $7d, $ff, $7d, $ff, $7d, $ff, $7d, $ff, $7d,
	db $ff, $7c, $ff, $7c, $ff, $7c, $7f, $7c, $ff, $7c, $ff, $7c, $ff, $7c, $ff, $7c,
	db $ff, $7b, $ff, $7b, $ff, $7b, $7f, $7b, $ff, $7b, $ff, $7b, $ff, $7b, $ff, $7b,
	db $ff, $7a, $ff, $7a, $ff, $7a, $7f, $7a, $ff, $7a, $ff, $7a, $ff, $7a, $ff, $7a,
	db $ff, $79, $ff, $79, $ff, $79, $7f, $79, $ff, $79, $ff, $79, $ff, $79, $ff, $79,
	db $ff, $78, $ff, $78, $ff, $78, $7f, $78, $ff, $78, $ff, $78, $ff, $78, $ff, $78,
	db $ff, $77, $ff, $77, $ff, $77, $7f, $77, $ff, $77, $ff, $77, $ff, $77, $ff, $77,
	db $ff, $76, $ff, $76, $ff, $76, $7f, $76, $ff, $76, $ff, $76, $ff, $76, $ff, $76,
	db $ff, $75, $ff, $75, $ff, $75, $7f, $75, $ff, $75, $ff, $75, $ff, $75, $ff, $75,
	db $ff, $74, $ff, $74, $ff, $74, $7f, $74, $ff, $74, $ff, $74, $ff, $74, $ff, $74,
	db $ff, $73, $ff, $73, $ff, $73, $7f, $73, $ff, $73, $ff, $73, $ff, $73, $ff, $73,
	db $ff, $72, $ff, $72, $ff, $72, $7f, $72, $ff, $72, $ff, $72, $ff, $72, $ff, $72,
	db $ff, $71, $ff, $71, $ff, $71, $7f, $71, $ff, $71, $ff, $71, $ff, $71, $ff, $71,
	db $ff, $70, $ff, $70, $ff, $70, $7f, $70, $ff, $70, $ff, $70, $ff, $70, $ff, $70,

	db $ff, $6f, $ff, $6f, $ff, $6f, $7f, $6f, $ff, $6f, $ff, $6f, $ff, $6f, $ff, $6f,
    db $ff, $6e, $ff, $6e, $ff, $6e, $7f, $6e, $ff, $6e, $ff, $6e, $ff, $6e, $ff, $6e,
    db $ff, $6d, $ff, $6d, $ff, $6d, $7f, $6d, $ff, $6d, $ff, $6d, $ff, $6d, $ff, $6d,
	db $ff, $6c, $ff, $6c, $ff, $6c, $7f, $6c, $ff, $6c, $ff, $6c, $ff, $6c, $ff, $6c,
	db $ff, $6b, $ff, $6b, $ff, $6b, $7f, $6b, $ff, $6b, $ff, $6b, $ff, $6b, $ff, $6b,
	db $ff, $6a, $ff, $6a, $ff, $6a, $7f, $6a, $ff, $6a, $ff, $6a, $ff, $6a, $ff, $6a,
	db $ff, $69, $ff, $69, $ff, $69, $7f, $69, $ff, $69, $ff, $69, $ff, $69, $ff, $69,
	db $ff, $68, $ff, $68, $ff, $68, $7f, $68, $ff, $68, $ff, $68, $ff, $68, $ff, $68,
	db $ff, $67, $ff, $67, $ff, $67, $7f, $67, $ff, $67, $ff, $67, $ff, $67, $ff, $67,
	db $ff, $66, $ff, $66, $ff, $66, $7f, $66, $ff, $66, $ff, $66, $ff, $66, $ff, $66,
	db $ff, $65, $ff, $65, $ff, $65, $7f, $65, $ff, $65, $ff, $65, $ff, $65, $ff, $65,
	db $ff, $64, $ff, $64, $ff, $64, $7f, $64, $ff, $64, $ff, $64, $ff, $64, $ff, $64,
	db $ff, $63, $ff, $63, $ff, $63, $7f, $63, $ff, $63, $ff, $63, $ff, $63, $ff, $63,
	db $ff, $62, $ff, $62, $ff, $62, $7f, $62, $ff, $62, $ff, $62, $ff, $62, $ff, $62,
	db $ff, $61, $ff, $61, $ff, $61, $7f, $61, $ff, $61, $ff, $61, $ff, $61, $ff, $61,
	db $ff, $60, $ff, $60, $ff, $60, $7f, $60, $ff, $60, $ff, $60, $ff, $60, $ff, $60,
BackgroundVramTileDataEnd:


BackgroundVramTileMapData:
    db $80, $81, $82, $83, $84, $85, $86, $87, $88, $89, $8a, $8b, $8c, $8d, $8e, $8f
    db $90, $91, $92, $93, $94, $95, $96, $97, $98, $99, $9a, $9b, $9c, $9d, $9e, $9f
    db $a0, $a1, $a2, $a3, $a4, $a5, $a6, $a7, $a8, $a9, $aa, $ab, $ac, $ad, $ae, $af
    db $b0, $b1, $b2, $b3, $b4, $b5, $b6, $b7, $b8, $b9, $ba, $bb, $bc, $bd, $be, $bf
    db $c0, $c1, $c2, $c3, $c4, $c5, $c6, $c7, $c8, $c9, $ca, $cb, $cc, $cd, $ce, $cf
    db $d0, $d1, $d2, $d3, $d4, $d5, $d6, $d7, $d8, $d9, $da, $db, $dc, $dd, $de, $df
BackgroundVramTileMapDataEnd:
