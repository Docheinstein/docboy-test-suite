INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "cgb.inc"

; Perform a HDMA (General Purpose) transfer while executing from HRAM using VRAM as source.
; HDMA should read FF instead of real data.

EntryPoint:
    DisablePPU

    ; Copy the code to HRAM (ff80)
    Memcpy $ff80, Code, CodeEnd - Code

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

    ; Jump to code in HRAM
    call $ff80

    ; --- transfer happens here ---

    DisablePPU

    ; The transferred data shouldn't have a corrupted
    ; byte at the beginning of the first chunk since we
    ; were reading from cpu bus, not ext bus.

    Memcmp $8400, ExpectedVramData, ExpectedVramDataEnd - ExpectedVramData
    jp nz, TestFailCGB

    jp TestSuccessCGB


Code:
    ; Bit 7 = 0 (general purpose)
    ; Length = 64 bytes / $10 - 1 => 3
    ld a, $03
    ldh [rHDMA5], a
    nop
    ret
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
    db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
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