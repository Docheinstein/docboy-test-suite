INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Check if writes to OAM pass after PPU is turned on.

EntryPoint:
    WaitVBlank

    ; Write something to OAM
    ld a, $01
    ld hl, $fe00 ; OAM
    ld [hl], a

    DisablePPU
    EnablePPU

    Nops 16

    ; Write OAM
    ld a, $02
    ld [hl], a
    ld b, a

    WaitVBlank

    ; Read it back
    ld a, [hl]
    ld b, a

    ; Check result: the write should have failed
    ld a, $01
    cp b
    jp nz, TestFail

    jp TestSuccess