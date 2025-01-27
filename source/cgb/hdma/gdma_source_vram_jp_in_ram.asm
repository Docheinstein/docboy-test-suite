;! MBC_TYPE=2
;! RAM_SIZE=3

INCLUDE "docboy.inc"

; Perform a HDMA (General Purpose) transfer while executing from HRAM using Cartridge RAM as source.
; HDMA should read FF instead of real data.

EntryPoint:
    DisablePPU

    ; Enable Cartridge RAM
    ld hl, $0000
    ld a, $0A
    ld [hl], a

    ; Copy the code to RAM (A400)
    Memcpy $A400, Code, CodeEnd - Code

    ; Set VRAM data
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

    ; Jump to code in RAM
    ld hl, $A400
    jp hl

Return:

    ; --- transfer happens here ---

    DisablePPU

    ; The transferred data should have a corrupted
    ; byte at the beginning of the first chunk.
    ld hl, $8400
    ld a, [hl]
    cp $ff
    jp z, TestFail

    Memcmp $8401, ExpectedVramData, ExpectedVramDataEnd - ExpectedVramData
    jp nz, TestFail

    jp TestSuccess


Code:
    ; Bit 7 = 0 (general purpose)
    ; Length = 64 bytes / $10 - 1 => 3
    ld a, $03
    ldh [rHDMA5], a
    nop
    jp Return
CodeEnd:

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

ExpectedVramData:
    db      $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
    db $cd, $cd, $cd, $cd, $cd, $cd, $cd, $cd
    db $cd, $cd, $cd, $cd, $cd, $cd, $cd, $cd
ExpectedVramDataEnd: