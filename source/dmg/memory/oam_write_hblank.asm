INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Writing to OAM during HBlank should write data correctly.

EntryPoint:
    DisablePPU

    ; Write something to OAM
    ld a, $12
    ld hl, $fe00
    ld [hl], a

    EnablePPU

    ; Skip glitched line 0
    Nops 114

    ; Wait HBlank
    WaitMode 0

    ; Write to OAM again
    ld a, $34
    ld [hl], a

    DisablePPU

    ; Read it back
    ld a, [hl]
    cp $34

    jp nz, TestFail
    jp TestSuccess
