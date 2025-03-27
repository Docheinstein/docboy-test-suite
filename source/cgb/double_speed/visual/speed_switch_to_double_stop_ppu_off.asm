INCLUDE "all.inc"

; Change speed with PPU off.
; LCD should take the neutral screen color.

EntryPoint:
    DisablePPU

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Reset OAM
    Memset $fe00, $00, 160

    ; Reset VRAM
    Memset $8000, $00, $2000

    ; Set VRAM0 data
    Memcpy $8800, BackgroundVram0TileData, BackgroundVram0TileDataEnd - BackgroundVram0TileData
    Memcpy $9800, BackgroundVram0TileMapData, BackgroundVram0TileMapDataEnd - BackgroundVram0TileMapData

    ; Write BG palettes
    ;               red+green             red+blue               green+blue             red
    SetBGP 0, %11111111, %00000011, %00011111, %01111100, %11100000, %01111111, %00011111, %00000000
    SetBGP 1, %11111111, %00000011, %00011111, %01111100, %11100000, %01111111, %00011111, %00000000
    SetBGP 2, %11111111, %00000011, %00011111, %01111100, %11100000, %01111111, %00011111, %00000000
    SetBGP 3, %11111111, %00000011, %00011111, %01111100, %11100000, %01111111, %00011111, %00000000
    SetBGP 4, %11111111, %00000011, %00011111, %01111100, %11100000, %01111111, %00011111, %00000000
    SetBGP 5, %11111111, %00000011, %00011111, %01111100, %11100000, %01111111, %00011111, %00000000
    SetBGP 6, %11111111, %00000011, %00011111, %01111100, %11100000, %01111111, %00011111, %00000000
    SetBGP 7, %11111111, %00000011, %00011111, %01111100, %11100000, %01111111, %00011111, %00000000

    ; Enable PPU
    EnablePPU

    ; Let it run for 60 frames
REPT 60
    LongWait 114 * 154
ENDR

    DisablePPU

    ; Switch to double speed
    stop

    halt

BackgroundVram0TileData:
    db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00
    db $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
BackgroundVram0TileDataEnd:

BackgroundVram0TileMapData:
    db $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80
    db $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80, $80
    db $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81
    db $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81, $81
    db $82, $82, $82, $82, $82, $82, $82, $82, $82, $82, $82, $82, $82, $82, $82, $82
    db $82, $82, $82, $82, $82, $82, $82, $82, $82, $82, $82, $82, $82, $82, $82, $82
    db $83, $83, $83, $83, $83, $83, $83, $83, $83, $83, $83, $83, $83, $83, $83, $83
    db $83, $83, $83, $83, $83, $83, $83, $83, $83, $83, $83, $83, $83, $83, $83, $83
BackgroundVram0TileMapDataEnd: