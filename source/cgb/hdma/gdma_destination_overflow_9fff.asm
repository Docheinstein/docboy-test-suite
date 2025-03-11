INCLUDE "all.inc"

; Perform a basic HDMA (General Purpose) transfer and make destination address exceed 0x9FFF.
; The transfer should overflow and continue to 0x8000 and complete normally.

EntryPoint:
    DisablePPU

    ; Set WRAM data
    Memset $C000, $ab, $100
    Memcpy $C000, Data, DataEnd - Data

    ; Dest address = 9F80
    ld a, $9F
    ldh [rHDMA3], a

    ld a, $80
    ldh [rHDMA4], a

    ; Set VRAM data
    Memset $8000, $cd, $100
    Memset $9F00, $ef, $100

    ; Source address = c000
    ld a, $c0
    ldh [rHDMA1], a

    ld a, $00
    ldh [rHDMA2], a

    ; Bit 7 = 0 (general purpose)
    ; Length = 256 bytes
    ld a, $0f
    ldh [rHDMA5], a

    ; --- transfer happens here ---

    Memcmp $8000, ExpectedVramData8000, ExpectedVramData8000End - ExpectedVramData8000
    jp nz, TestFail

    Memcmp $9F00, ExpectedVramData9F00, ExpectedVramData9F00End - ExpectedVramData9F00
    jp nz, TestFail

    jp TestSuccess

Data:
    db $00, $11, $22, $33, $44, $55, $66, $77
    db $88, $99, $aa, $bb, $cc, $dd, $ee, $ff
    db $11, $22, $33, $44, $55, $66, $77, $88
    db $99, $aa, $bb, $cc, $dd, $ee, $ff, $00
    db $22, $33, $44, $55, $66, $77, $88, $99
    db $aa, $bb, $cc, $dd, $ee, $ff, $00, $11
    db $33, $44, $55, $66, $77, $88, $99, $aa
    db $bb, $cc, $dd, $ee, $ff, $00, $11, $22
    db $44, $55, $66, $77, $88, $99, $aa, $bb
    db $cc, $dd, $ee, $ff, $00, $11, $22, $33
    db $55, $66, $77, $88, $99, $aa, $bb, $cc
    db $dd, $ee, $ff, $00, $11, $22, $33, $44
    db $66, $77, $88, $99, $aa, $bb, $cc, $dd
    db $ee, $ff, $00, $11, $22, $33, $44, $55
    db $77, $88, $99, $aa, $bb, $cc, $dd, $ee
    db $ff, $00, $11, $22, $33, $44, $55, $66
    db $88, $99, $aa, $bb, $cc, $dd, $ee, $ff
    db $00, $11, $22, $33, $44, $55, $66, $77
    db $99, $aa, $bb, $cc, $dd, $ee, $ff, $00
    db $11, $22, $33, $44, $55, $66, $77, $88
    db $aa, $bb, $cc, $dd, $ee, $ff, $00, $11
    db $22, $33, $44, $55, $66, $77, $88, $99
    db $bb, $cc, $dd, $ee, $ff, $00, $11, $22
    db $33, $44, $55, $66, $77, $88, $99, $aa
    db $cc, $dd, $ee, $ff, $00, $11, $22, $33
    db $44, $55, $66, $77, $88, $99, $aa, $bb
    db $dd, $ee, $ff, $00, $11, $22, $33, $44
    db $55, $66, $77, $88, $99, $aa, $bb, $cc
    db $ee, $ff, $00, $11, $22, $33, $44, $55
    db $66, $77, $88, $99, $aa, $bb, $cc, $dd
    db $ff, $00, $11, $22, $33, $44, $55, $66
    db $77, $88, $99, $aa, $bb, $cc, $dd, $ee
DataEnd:

ExpectedVramData8000:
    db $88, $99, $aa, $bb, $cc, $dd, $ee, $ff
    db $00, $11, $22, $33, $44, $55, $66, $77
    db $99, $aa, $bb, $cc, $dd, $ee, $ff, $00
    db $11, $22, $33, $44, $55, $66, $77, $88
    db $aa, $bb, $cc, $dd, $ee, $ff, $00, $11
    db $22, $33, $44, $55, $66, $77, $88, $99
    db $bb, $cc, $dd, $ee, $ff, $00, $11, $22
    db $33, $44, $55, $66, $77, $88, $99, $aa
    db $cc, $dd, $ee, $ff, $00, $11, $22, $33
    db $44, $55, $66, $77, $88, $99, $aa, $bb
    db $dd, $ee, $ff, $00, $11, $22, $33, $44
    db $55, $66, $77, $88, $99, $aa, $bb, $cc
    db $ee, $ff, $00, $11, $22, $33, $44, $55
    db $66, $77, $88, $99, $aa, $bb, $cc, $dd
    db $ff, $00, $11, $22, $33, $44, $55, $66
    db $77, $88, $99, $aa, $bb, $cc, $dd, $ee
    db $cd, $cd, $cd, $cd, $cd, $cd, $cd, $cd
    db $cd, $cd, $cd, $cd, $cd, $cd, $cd, $cd
    db $cd, $cd, $cd, $cd, $cd, $cd, $cd, $cd
    db $cd, $cd, $cd, $cd, $cd, $cd, $cd, $cd
    db $cd, $cd, $cd, $cd, $cd, $cd, $cd, $cd
    db $cd, $cd, $cd, $cd, $cd, $cd, $cd, $cd
    db $cd, $cd, $cd, $cd, $cd, $cd, $cd, $cd
    db $cd, $cd, $cd, $cd, $cd, $cd, $cd, $cd
    db $cd, $cd, $cd, $cd, $cd, $cd, $cd, $cd
    db $cd, $cd, $cd, $cd, $cd, $cd, $cd, $cd
    db $cd, $cd, $cd, $cd, $cd, $cd, $cd, $cd
    db $cd, $cd, $cd, $cd, $cd, $cd, $cd, $cd
    db $cd, $cd, $cd, $cd, $cd, $cd, $cd, $cd
    db $cd, $cd, $cd, $cd, $cd, $cd, $cd, $cd
    db $cd, $cd, $cd, $cd, $cd, $cd, $cd, $cd
    db $cd, $cd, $cd, $cd, $cd, $cd, $cd, $cd
ExpectedVramData8000End:

ExpectedVramData9F00:
    db $ef, $ef, $ef, $ef, $ef, $ef, $ef, $ef
    db $ef, $ef, $ef, $ef, $ef, $ef, $ef, $ef
    db $ef, $ef, $ef, $ef, $ef, $ef, $ef, $ef
    db $ef, $ef, $ef, $ef, $ef, $ef, $ef, $ef
    db $ef, $ef, $ef, $ef, $ef, $ef, $ef, $ef
    db $ef, $ef, $ef, $ef, $ef, $ef, $ef, $ef
    db $ef, $ef, $ef, $ef, $ef, $ef, $ef, $ef
    db $ef, $ef, $ef, $ef, $ef, $ef, $ef, $ef
    db $ef, $ef, $ef, $ef, $ef, $ef, $ef, $ef
    db $ef, $ef, $ef, $ef, $ef, $ef, $ef, $ef
    db $ef, $ef, $ef, $ef, $ef, $ef, $ef, $ef
    db $ef, $ef, $ef, $ef, $ef, $ef, $ef, $ef
    db $ef, $ef, $ef, $ef, $ef, $ef, $ef, $ef
    db $ef, $ef, $ef, $ef, $ef, $ef, $ef, $ef
    db $ef, $ef, $ef, $ef, $ef, $ef, $ef, $ef
    db $ef, $ef, $ef, $ef, $ef, $ef, $ef, $ef
    db $00, $11, $22, $33, $44, $55, $66, $77
    db $88, $99, $aa, $bb, $cc, $dd, $ee, $ff
    db $11, $22, $33, $44, $55, $66, $77, $88
    db $99, $aa, $bb, $cc, $dd, $ee, $ff, $00
    db $22, $33, $44, $55, $66, $77, $88, $99
    db $aa, $bb, $cc, $dd, $ee, $ff, $00, $11
    db $33, $44, $55, $66, $77, $88, $99, $aa
    db $bb, $cc, $dd, $ee, $ff, $00, $11, $22
    db $44, $55, $66, $77, $88, $99, $aa, $bb
    db $cc, $dd, $ee, $ff, $00, $11, $22, $33
    db $55, $66, $77, $88, $99, $aa, $bb, $cc
    db $dd, $ee, $ff, $00, $11, $22, $33, $44
    db $66, $77, $88, $99, $aa, $bb, $cc, $dd
    db $ee, $ff, $00, $11, $22, $33, $44, $55
    db $77, $88, $99, $aa, $bb, $cc, $dd, $ee
    db $ff, $00, $11, $22, $33, $44, $55, $66
ExpectedVramData9F00End: