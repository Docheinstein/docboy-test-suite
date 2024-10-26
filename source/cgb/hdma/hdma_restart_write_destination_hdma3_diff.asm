INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "cgb.inc"

; Perform a HDMA (HBlank) transfer and restart it after 1 transferred chunk.
; Write a different HDMA3.

EntryPoint:
    DisablePPU

    ; Copy data to WRAM2
    Memcpy $D000, VramData, VramDataEnd - VramData

    ; Set VRAM data
    Memset $8000, $ab, $60
    Memset $8400, $cd, $60

    ; Source address = D000
    ld a, $D0
    ldh [rHDMA1], a

    ld a, $00
    ldh [rHDMA2], a

    ; Dest address = 8000
    ld a, $80
    ldh [rHDMA3], a

    ld a, $00
    ldh [rHDMA4], a

    ; Enable PPU again
    EnablePPU

    ; Skip glitched line 0
    Nops 114

    ; Bit 7 = 1 (HBlank)
    ; Length = 64 bytes / $10 - 1 => 3
    ld a, $83
    ldh [rHDMA5], a

    ; Wait an HBlank
    Nops 114

    ; Dest address = 8400
    ld a, $84
    ldh [rHDMA3], a

    ; Bit 7 = 1 (HBlank)
    ; Length = 64 bytes / $10 - 1 => 3
    ld a, $83
    ldh [rHDMA5], a

    ; Wait for enough HBlanks for transfer to happen
    ; (no precise timing check)
    Nops 5 * 114

    ; Disable PPU
    DisablePPU

    ; 1 chunk should have been transferred to 8000
    Memcmp $8000, VramData, $10
    jp nz, TestFailCGB

    Memtest $8010, $ab, $50
    jp nz, TestFailCGB

    ; 4 chunks should have been transferred to 8410 from D010
    Memtest $8400, $cd, $10
    jp nz, TestFailCGB

    Memcmp $8410, VramData + $10, $40
    jp nz, TestFailCGB

    Memtest $8450, $cd, $10
    jp nz, TestFailCGB


    jp TestSuccessCGB

VramData:
    db $00, $11, $22, $33, $44, $55, $66, $77, $88, $99, $aa, $bb, $cc, $dd, $ee, $ff
    db $11, $22, $33, $44, $55, $66, $77, $88, $99, $aa, $bb, $cc, $dd, $ee, $ff, $00
    db $22, $33, $44, $55, $66, $77, $88, $99, $aa, $bb, $cc, $dd, $ee, $ff, $00, $11
    db $33, $44, $55, $66, $77, $88, $99, $aa, $bb, $cc, $dd, $ee, $ff, $00, $11, $22
    db $44, $55, $66, $77, $88, $99, $aa, $bb, $cc, $dd, $ee, $ff, $00, $11, $22, $33
VramDataEnd: