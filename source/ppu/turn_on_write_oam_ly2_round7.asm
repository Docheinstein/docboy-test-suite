INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Check if writes to OAM pass after PPU is turned on.

EntryPoint:
    WaitVBlank

    ; Write something to OAM
    ld a, $01
    ld hl, $fe00 ; OAM
    ld [hl], a

    ResetPPU

    Nops 246

    ; Write OAM
    ld a, $02
    ld [hl], a
    ld b, a

    WaitVBlank

    ; Read it back
    ld a, [hl]
    ld b, a

    ; Check result: we should have written OAM correctly
    ld a, $01
    cp b
    jp nz, TestFail

    jp TestSuccess