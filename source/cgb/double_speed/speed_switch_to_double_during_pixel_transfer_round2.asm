INCLUDE "all.inc"

; Check how speed switch affects VRAM/OAM locking in various PPU modes.
; Switch at Pixel Transfer.
; Resume at Pixel Transfer.

EntryPoint:
    DisablePPU

    ; Set SCX=0
    ld a, $00
    ldh [rSCX], a

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Set OAM Data
    Memset $fe00, $00, 160
    Memcpy $fe00, OamData, OamDataEnd - OamData

    Memcpy $8000, VramData, VramDataEnd - VramData

    EnablePPU_WithSprites

    ; Go to line 30
    LongWait 114 * 30

    Nops 50

    ; <-- Switch at dot ~ 200 -->

    ; Switch to double speed
    stop

    ; <-- Resume at dot ~ 80 -->

    Nops 135

    ; Read STAT
    ldh a, [rSTAT]
    cp $80

    jp nz, TestFail
    jp TestSuccess

VramData:
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00
    db $ff, $00, $ff, $00, $ff, $00, $ff, $00
VramDataEnd:

OamData:
    db $10, $10, $00, $00
    db $10, $18, $00, $00
    db $10, $20, $00, $00
    db $10, $28, $00, $00
    db $10, $30, $00, $00
    db $10, $38, $00, $00
    db $10, $40, $00, $00
    db $10, $48, $00, $00
    db $10, $50, $00, $00
    db $10, $58, $00, $00

    db $20, $18, $00, $00
    db $20, $20, $00, $00
    db $20, $28, $00, $00
    db $20, $30, $00, $00
    db $20, $38, $00, $00
    db $20, $40, $00, $00
    db $20, $48, $00, $00
    db $20, $50, $00, $00
    db $20, $58, $00, $00
    db $20, $60, $00, $00

    db $30, $20, $00, $00
    db $30, $28, $00, $00
    db $30, $30, $00, $00
    db $30, $38, $00, $00
    db $30, $40, $00, $00
    db $30, $48, $00, $00
    db $30, $50, $00, $00
    db $30, $58, $00, $00
    db $30, $60, $00, $00
    db $30, $68, $00, $00

    db $40, $28, $00, $00
    db $40, $30, $00, $00
    db $40, $38, $00, $00
    db $40, $40, $00, $00
    db $40, $48, $00, $00
    db $40, $50, $00, $00
    db $40, $58, $00, $00
    db $40, $60, $00, $00
    db $40, $68, $00, $00
    db $40, $70, $00, $00
OamDataEnd: