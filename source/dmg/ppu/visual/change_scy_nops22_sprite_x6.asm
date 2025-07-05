INCLUDE "all.inc"

; Change SCY during pixel transfer at different fetcher
; phases (uses a sprite to change phase).

EntryPoint:
    ; Disable PPU
    DisablePPU

    ; Set BGP
    ld a, %11100100
    ldh [rBGP], a

    ; Reset VRAM and OAM
    ; Reset VRAM
    Memset $8000, $00, $2000
    Memset $fe00, $00, 160

    ; Set OAM data
    Memcpy $fe00, OamData, OamDataEnd - OamData

    ; Set BG VRAM data
    Memcpy $8800, BackgroundVramTileData, BackgroundVramTileDataEnd - BackgroundVramTileData
    Memcpy $9800, BackgroundVramTileMapData, BackgroundVramTileMapDataEnd - BackgroundVramTileMapData

    ; Reset interrupts
    xor a
    ldh [rIF], a

    ; Enable VBLANK interrupt
    ld a, IEF_VBLANK
    ldh [rIE], a

    ; Enable PPU
    EnablePPU_WithSprites

Loop:
    ; -- Begin of frame --

    ; Wait 8 lines
    Wait 8 * 114

    ; Go to pixel transfer of line 8
    Nops 22

    ; Change SCY
    ld a, $01
    ldh [rSCY], a

    ; Wait HBlank
    WaitMode 00

    ; Reset SCY
    xor a
    ldh [rSCY], a

    ; Wait VBlank
    ei

    halt
    nop

TestRestart:
    ; Soft Breakpoint: good time to take a screenshot
    ld b, b
    
    Wait 1125

    jp Loop

OamData:
    db 24, 6, 0, 0
OamDataEnd:

BackgroundVramTileData:
    ; First row
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff

    ; Second row
    db $80, $00, $01, $01, $02, $02, $03, $03, $04, $04, $05, $05, $06, $06, $87, $07,
    db $80, $00, $41, $01, $02, $02, $03, $03, $04, $04, $05, $05, $86, $06, $87, $07,
    db $80, $00, $41, $01, $22, $02, $03, $03, $04, $04, $85, $05, $86, $06, $87, $07,
BackgroundVramTileDataEnd:


BackgroundVramTileMapData:
    db $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80,
    db $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80,
    db $81, $82, $83
BackgroundVramTileMapDataEnd:


SECTION "VBlank handler", ROM0[$40]
    pop hl ; avoid stack overflow
    jp TestRestart
