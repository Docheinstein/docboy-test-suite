INCLUDE "all.inc"

; Check what is read from VRAM after PPU is turned on.

EntryPoint:
    WaitVBlank

    ; Write something to VRAM
    ld a, $01
    ld hl, $8000 ; VRAM
    ld [hl], a

    ; Reset PPU
    DisablePPU
    EnablePPU

    Nops 14

    ; Read VRAM
    ld hl, $8000
    ld a, [hl]
    ld b, a

    ; Check result: we should read VRAM correctly
    ld a, $01
    cp b
    jp nz, TestFail

    jp TestSuccess