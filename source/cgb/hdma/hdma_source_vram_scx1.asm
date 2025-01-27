INCLUDE "docboy.inc"

; Perform a HDMA (HBlank) transfer using VRAM as source.
; HDMA should read FF instead of real data.
; The first read block of each chunk should be a corrupted byte.
; SCX=1

EntryPoint:
    DisablePPU

    ; Set SCX=1
    ld a, $01
    ldh [rSCX], a

    ; Set VRAM data
    Memset $8000, $ab, $80
    Memset $8400, $cd, $80

    Memcpy $8000, VramData, VramDataEnd - VramData

    ; Source address = 8000
    ld a, $80
    ldh [rHDMA1], a

    ld a, $00
    ldh [rHDMA2], a

    ; Dest address = 8400
    ld a, $84
    ldh [rHDMA3], a

    ld a, $00
    ldh [rHDMA4], a

    ; Enable PPU again
    EnablePPU

    ; Skip glitched line 0
    Nops 114

    ; Bit 7 = 1 (general purpose)
    ; Length = 64 bytes / $10 - 1 => 3
    ld a, $83
    ldh [rHDMA5], a

    ; --- transfer happens here ---

    ; Wait for enough HBlanks to happen
    ; (no precise timing check
    Nops 4 * 114

    DisablePPU

    ld hl, $8400
    ld a, [hl]

    ; The transferred data should have the first
    ; byte of chunk corrupted.
    ; db $XX, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    ; db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    ; db $XX, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    ; db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    ; db $XX, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    ; db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    ; db $XX, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    ; db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff

    ; The corrupted byte shouldn't be FF
    cp $ff
    jp z, TestFail

    ld d, a

    Memcheck $8400, d
    jp nz, TestFail

    Memcheck $8410, d
    jp nz, TestFail

    Memcheck $8420, d
    jp nz, TestFail

    Memcheck $8430, d
    jp nz, TestFail

    Memtest $8401, $ff, 15
    jp nz, TestFail

    Memtest $8411, $ff, 15
    jp nz, TestFail

    Memtest $8421, $ff, 15
    jp nz, TestFail

    Memtest $8431, $ff, 15
    jp nz, TestFail

    jp TestSuccess

VramData:
    db $00, $11, $22, $33, $44, $55, $66, $77
    db $88, $99, $aa, $bb, $cc, $dd, $ee, $ff
    db $11, $22, $33, $44, $55, $66, $77, $88
    db $99, $aa, $bb, $cc, $dd, $ee, $ff, $00
    db $22, $33, $44, $55, $66, $77, $88, $99
    db $aa, $bb, $cc, $dd, $ee, $ff, $00, $11
    db $33, $44, $55, $66, $77, $88, $99, $aa
    db $bb, $cc, $dd, $ee, $ff, $00, $11, $22
VramDataEnd: