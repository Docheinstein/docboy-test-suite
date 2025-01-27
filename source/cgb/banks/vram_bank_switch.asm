INCLUDE "docboy.inc"

; Check that VRAM VBK can be used to switch between 2 different VRAM banks.

MACRO WriteVRAM
    ; Switch VRAM bank
    ld a, \1
    ldh [rVBK], a

    ; Write
    ld a, \2
    ld hl, $8000
    ld [hl], a
ENDM

MACRO ExpectVRAM
    ; Switch WRAM bank
    ld a, \1
    ldh [rVBK], a

    ; Read
    ld hl, $8000
    ld a, [hl]
    ld b, a

    ld a, \2
    cp b

    jp nz, TestFail
ENDM

EntryPoint:
    WriteVRAM $00, $11
    WriteVRAM $01, $22

    ExpectVRAM $00, $11
    ExpectVRAM $01, $22

    jp TestSuccess
