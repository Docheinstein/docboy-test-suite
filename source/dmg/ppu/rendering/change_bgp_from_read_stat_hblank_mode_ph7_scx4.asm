
INCLUDE "docboy.inc"

; Check the write timing by changing BGP in the middle of a line
; in pixel transfer mode while coming from a read of STAT yielding HBlank mode.

EntryPoint:
    ; Disable PPU
    DisablePPU

    ; Write SCX=4
    ld a, 4
    ldh [rSCX], a

    ; Write BGP
    ld a, %11100100
    ldh [rBGP], a

    ; Set BG VRAM data
    Memcpy $9010, BackgroundVramTileData, BackgroundVramTileDataEnd - BackgroundVramTileData
    Memcpy $9809, BackgroundVramTileMapData, BackgroundVramTileMapDataEnd - BackgroundVramTileMapData

    ; Enable PPU
    ld a, LCDCF_ON | LCDCF_BGON
	ldh [rLCDC], a

    ; - Begin of frame -

    ; Skip 1 frame
    LongWait 114 * 154

    ; - Begin of frame -

    ; Wait 7 lines
    LongWait 114 * 7
	
	; Add some phase
	Nops 7
	
	; Wait to read HBlank from STAT to proceed
    ld b, %11
WaitHBlankLoop:
    ldh a, [rSTAT]
    and b
    jp nz, WaitHBlankLoop

	; Wait middle of line 8
    Nops 79

    ; Write different BGP
    ld a, %11100111
    ldh [rBGP], a

    WaitVBlank

    ; Soft Breakpoint: good time to take a screenshot
    ld b, b

    halt
    nop

BackgroundVramTileData:
    db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01,
    db $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80,
BackgroundVramTileDataEnd:

BackgroundVramTileMapData:
    db 1, 2
BackgroundVramTileMapDataEnd:
