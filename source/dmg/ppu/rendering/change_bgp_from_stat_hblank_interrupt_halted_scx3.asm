INCLUDE "docboy.inc"

; Check the write timing by changing BGP in the middle of a line
; in pixel transfer mode while coming from a PPU reset.

EntryPoint:
    ; Disable PPU
    DisablePPU

    ; Write SCX=3
    ld a, 03
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

    ; Approach next VBlank
    LongWait 114 * 143

    ; Enable STAT's HBlank interrupt
    xor a
    ldh [rIF], a

    ld a, IEF_STAT
    ldh [rIE], a

    ld a, STATF_MODE00
    ldh [rSTAT], a

    ; Enable interrupt
    ei

    ; Halt
    halt
    nop

    ; We should not reach this point
    jp TestFail

TestFinish:
    ; Skip rest of last 10 lines
    LongWait 1183

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


SECTION "STAT handler", ROM0[$48]
    jp TestFinish
