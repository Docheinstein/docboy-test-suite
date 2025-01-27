INCLUDE "docboy.inc"

; Check what is read from OAM at LY=1 after PPU is turned on.

EntryPoint:
    WaitVBlank

    ; Write something to OAM
    ld a, $01
    ld hl, $fe00 ; OAM
    ld [hl], a

    ; Reset PPU
    DisablePPU
    EnablePPU

    ; Wait LY=1
    Nops 131

    ; Read OAM
    ld hl, $fe00
    ld a, [hl]
    ld b, a

    ; Check result: we should read FF instead
    ld a, $ff
    cp b
    jp nz, TestFail

    jp TestSuccess