INCLUDE "all.inc"

; Check if writes to OAM pass after PPU is turned on.

EntryPoint:
    WaitVBlank

    ; Write something to OAM
    ld a, $01
    ld hl, $fe00 ; OAM
    ld [hl], a

    ; Reset PPU
    DisablePPU
    EnablePPU

    Nops 243

    ; Write OAM
    ld a, $02
    ld [hl], a
    ld b, a

    WaitVBlank

    ; Read it back
    ld a, [hl]
    ld b, a

    ; Check result: the write should have failed
    ; (This strange: OAM is kind of released for a cycle)
    ld a, $02
    cp b
    jp nz, TestFail

    jp TestSuccess