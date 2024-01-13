INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "vram.inc"
INCLUDE "dma.inc"

; Check the write timing by changing BGP in the middle of a line
; in pixel transfer mode while coming from a PPU reset.

EntryPoint:
    ; Disable PPU
    DisablePPU

    ; Write SCX=0
    ld a, 00
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

    ; Go line 2 of next frame
    LongWait 114 * 156

    ; Go out of OAM scan
    Nops 20

    ; Enable STAT's OAM interrupt
    xor a
    ldh [rIF], a

    ld a, IEF_STAT
    ldh [rIE], a

    ld a, STATF_MODE10
    ldh [rSTAT], a

    ; Enable interrupt
    ei

    ; Busy wait
    Nops 114

    ; We should not reach this point
    jp TestFail

TestFinish:
    ; - Begin of line 3 + Interrupt Dispatch + Jump -

    ; Wait middle of line 8
    LongWait 601

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
