INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Check what is read from OAM at LY=2 after PPU is turned on.

EntryPoint:
    WaitVBlank

    ; Write something to OAM
    ld a, $01
    ld hl, $fe00 ; OAM
    ld [hl], a

    ResetPPU

    ; Wait LY=2
    Nops 222

    ; Read OAM
    ld hl, $fe00
    ld a, [hl]
    ld b, a

    ; Check result: we should read FF instead
    ld a, $ff
    cp b
    jp nz, TestFail

    jp TestSuccess