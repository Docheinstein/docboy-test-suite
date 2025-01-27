INCLUDE "docboy.inc"

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

    Nops 129

    ; Read VRAM
    ld hl, $8000
    ld a, [hl]
    ld b, a

    ; Check result: we should read FF instead
    ld a, $ff
    cp b
    jp nz, TestFail

    jp TestSuccess