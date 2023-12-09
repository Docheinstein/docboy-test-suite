INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Check what is read from OAM after PPU is turned on.

EntryPoint:
    WaitVBlank

    ; Write something to OAM
    ld a, $01
    ld hl, $fe00 ; OAM
    ld [hl], a

    DisablePPU
    EnablePPU

    Nops 15

    ; Read OAM
    ld hl, $fe00
    ld a, [hl]
    ld b, a

    ; Check result: we should read FF instead
    ld a, $ff
    cp b
    jp nz, TestFail

    jp TestSuccess