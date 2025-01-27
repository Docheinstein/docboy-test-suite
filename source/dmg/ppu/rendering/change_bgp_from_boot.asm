INCLUDE "docboy.inc"

; Check the write timing by changing BGP in the middle of a line
; in pixel transfer mode while coming from boot.

EntryPoint:
    ; Disable OBJ
	ld a, LCDCF_ON | LCDCF_BGON
	ldh [rLCDC], a

    ; Write SCX=0
    ld a, 00
    ldh [rSCX], a

    ; Write BGP
    ld a, %11100100
    ldh [rBGP], a

    ; Busy wait until next frame's VBlank to write to VRAM
    LongWait 114 * 144

    ; Set BG VRAM data
    Memcpy $9010, BackgroundVramTileData, BackgroundVramTileDataEnd - BackgroundVramTileData
    Memcpy $9809, BackgroundVramTileMapData, BackgroundVramTileMapDataEnd - BackgroundVramTileMapData

    ; Align with begin of next frame
    LongWait 644

    ; - Begin of frame -

    ; Skip 1 frame
    LongWait 114 * 154

    ; - Begin of frame -

    ; Wait middle of line 8
    LongWait 950

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