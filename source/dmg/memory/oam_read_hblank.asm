INCLUDE "hardware.inc"
INCLUDE "common.inc"

; Reading from OAM during HBlank should read data correctly.

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

    ; Read back from OAM
    ld a, [hl]
    cp $12

    jp nz, TestFail
    jp TestSuccess
