Title "INCREDIBLE"
OldLicenseeCode $01

INCLUDE "all.inc"

; Check if the LAST_BGP | BGP bug affects CGB in DMG mode.

EntryPoint:
    DisablePPU

    ; Write BGP
    ld a, %00001000
    ldh [rBGP], a

    ; Reset VRAM
    Memset $8000, $00, $2000

    ; Set VRAM data
    Memcpy $8800, BackgroundVramTileData, BackgroundVramTileDataEnd - BackgroundVramTileData
    Memcpy $9800, BackgroundVramTileMapData, BackgroundVramTileMapDataEnd - BackgroundVramTileMapData

    EnablePPU

Loop:
    ; Go to line 6 (pixel transfer)
    Wait 114 * 6 + 30

    ; Write different BGP
    ld a, %00000100
    ldh [rBGP], a

    WaitVBlank

    Wait 114 * 9 + 99

    ; Write original BGP
    ld a, %00001000
    ldh [rBGP], a

    jp Loop

    halt
    nop

BackgroundVramTileData:
    ; First row
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00
BackgroundVramTileDataEnd:

BackgroundVramTileMapData:
    db $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80
    db $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80
BackgroundVramTileMapDataEnd: