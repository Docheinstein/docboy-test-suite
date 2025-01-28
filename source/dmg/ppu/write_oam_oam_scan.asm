INCLUDE "all.inc"

EntryPoint:
    WaitVBlank

    ; Write something to OAM
    ld a, $01
    ld hl, $fe00 ; OAM
    ld [hl], a

    ; Wait oam scan
    WaitMode 2

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