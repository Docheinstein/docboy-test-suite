INCLUDE "docboy.inc"

; Check if writes to OAM pass after PPU is turned on.

EntryPoint:
    WaitVBlank

    ; Copy data to OAM
    Memcpy $fe00, OAMData, OAMDataEnd - OAMData

    ld hl, $fe00 ; OAM

    ; Reset PPU
    DisablePPU
    EnablePPU

    Nops 244

    ; Write OAM
    ld a, $02
    ld [hl], a
    ld b, a

    WaitVBlank

    ; Read it back
    ld a, [hl]
    ld b, a

    ; Check result: we should have written OAM correctly
    ld a, $20
    cp b
    jp nz, TestFail

    jp TestSuccess

OAMData:
; 10 oam entries in a position inside the viewport
db $20, $20, $00, $00
db $20, $20, $00, $00
db $20, $20, $00, $00
db $20, $20, $00, $00
db $20, $20, $00, $00
db $20, $20, $00, $00
db $20, $20, $00, $00
db $20, $20, $00, $00
db $20, $20, $00, $00
db $20, $20, $00, $00
OAMDataEnd:
