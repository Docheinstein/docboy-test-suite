INCLUDE "all.inc"

; Check that BG vertical flip works.
; (And implicitly check for a bare working VRAM1).

EntryPoint:
    DisablePPU

    ; Reset OAM
    Memset $fe00, $00, 160

    ; Reset VRAM0
    ; Reset VRAM
    Memset $8000, $00, $2000

    ; Set VRAM0 data
    Memcpy $8800, BackgroundVram0TileData, BackgroundVram0TileDataEnd - BackgroundVram0TileData
    Memcpy $9800, BackgroundVram0TileMapData, BackgroundVram0TileMapDataEnd - BackgroundVram0TileMapData

    ld a, 1
    ldh [rVBK], a

    ; Reset VRAM1
    ; Reset VRAM
    Memset $8000, $00, $2000

    xor a
    ldh [rVBK], a

    ; Write BG palettes
    ;               red+green             red+blue               green+blue             grey
    SetBGP 0, %11111111, %00000011, %00011111, %01111100, %11100000, %01111111, %11100111, %00011100
    ;                 red                  green                   blue                black
    SetBGP 1, %00011111, %00000000, %11100000, %00000011, %00000000, %01111100, %00000000, %00000000

    ; Write BG attributes to VRAM1
    ld a, 1
    ldh [rVBK], a

    ; Bank = 0
    ; BG palette = 1
    ; Y Flip = 1
    ld a, $41
    ld hl, $9800
    ld [hl], a

    ; BG palette = 1
    ; Y Flip = 1
    ld a, $41
    ld hl, $9821
    ld [hl], a

    ; BG palette = 1
    ; Y Flip = 0
    ld a, $01
    ld hl, $9842
    ld [hl], a

    xor a
    ldh [rVBK], a

    ; Enable PPU
    EnablePPU

    HaltForever

BackgroundVram0TileData:
    db $7e, $7e, $60, $60, $60, $60, $7c, $7c, $60, $60, $60, $60, $60, $60, $00, $00,
    db $3e, $3e, $60, $60, $60, $60, $6e, $6e, $66, $66, $66, $66, $3e, $3e, $00, $00,
    db $3e, $3e, $60, $60, $60, $60, $6e, $6e, $66, $66, $66, $66, $3e, $3e, $00, $00,
    db $3e, $3e, $60, $60, $60, $60, $6e, $6e, $66, $66, $66, $66, $3e, $3e, $00, $00,
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