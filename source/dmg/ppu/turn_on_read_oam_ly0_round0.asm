INCLUDE "all.inc"

; Check what is read from OAM after PPU is turned on.

EntryPoint:
    WaitVBlank

    ; Write something to OAM
    ld a, $01
    ld hl, $fe00 ; OAM
    ld [hl], a

    ; Reset PPU
    DisablePPU
    EnablePPU

    ; Read OAM
    ld hl, $fe00
    ld a, [hl]
    ld b, a

    ; Check result: we should read OAM correctly
    ld a, $01
    cp b
    jp nz, TestFail

    jp TestSuccess