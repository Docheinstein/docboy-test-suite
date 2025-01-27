INCLUDE "docboy.inc"

; Check the value of STAT after PPU is turned on with LYC=1.

EntryPoint:
    WaitVBlank

    ; Write something to OAM
    ld a, $01
    ld hl, $fe00 ; OAM
    ld [hl], a

    ; Wait pixel transfer
    WaitMode 3

    ; Try to write something to OAM
    ld a, $02
    ld [hl], a

    WaitVBlank

    ; Read it back
    ld hl, $fe00 ; OAM
    ld a, [hl]
    ld b, a

    ; Check result
    ld a, $01
    cp b
    jp nz, TestFail

    jp TestSuccess