INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "cgb.inc"

; Perform a basic HDMA (HBlank) transfer and abort it instantly.
; Check that no data is transferred.

EntryPoint:
    DisablePPU

    ; Copy data to WRAM2
    Memcpy $D000, VramData, VramDataEnd - VramData

    ; Set VRAM data
    Memset $8000, $ab, $40

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

    ; Just wait a bit
    Nops 4

    ; Bit 7 = 0 => Abort HDMA transfer
    ld a, $77
    ldh [rHDMA5], a

    ; Wait for enough HBlanks for transfer to (potentially) happen
    Nops 4 * 114

    ; Disable PPU
    DisablePPU

    ; No chunks should have been transferred.
    Memtest $8000, $ab, 40

    jp nz, TestFailCGB

    jp TestSuccessCGB

VramData:
    db $00, $11, $22, $33, $44, $55, $66, $77, $88, $99, $aa, $bb, $cc, $dd, $ee, $ff
    db $11, $22, $33, $44, $55, $66, $77, $88, $99, $aa, $bb, $cc, $dd, $ee, $ff, $00
    db $22, $33, $44, $55, $66, $77, $88, $99, $aa, $bb, $cc, $dd, $ee, $ff, $00, $11
    db $33, $44, $55, $66, $77, $88, $99, $aa, $bb, $cc, $dd, $ee, $ff, $00, $11, $22
VramDataEnd: