INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "vram.inc"
INCLUDE "dma.inc"

; Running DMA during OAM scan should prevent PPU to read from OAM at all.
;
; DMA source : WRAM1 (c000) [ext bus]
; DMA dest   : OAM   (fe00) [oam bus]
; CPU routine: HRAM  (ff80) [cpu bus]

EntryPoint:
    ; Disable
    DisablePPU

    ; Reset VRAM and OAM
    ResetVRAM
    ResetOAM

    ; Write OBJ palette
    ld a, %11100100
    ldh [rOBP0], a
    ldh [rOBP1], a

    ; Write BGP palette
    ld a, %11100100
    ldh [rBGP], a

    ; Copy blocks data to OAM
    Memcpy $fe00, OamData, OamDataEnd - OamData

    ; Copy columns OAM data to DMA source (WRAM1 : c000)
    Memcpy $c000, OamData, OamDataEnd - OamData

    ; Copy OBJ Tile Data
    Memcpy $8000, OamTileData, OamTileDataEnd - OamTileData

    ; Copy the DMA transfer routine to HRAM (ff80)
    SetupDmaTransfer $c0

    ; Enable STAT interrupt
    ld a, IEF_STAT
    ldh [rIE], a

    ; Enable HBLANK interrupt
    ld a, STATF_MODE00
    ldh [rSTAT], a

    EnablePPU

Loop:
    ; Wait until HBLANK of line 4
    WaitScanline 4

    ; Reset IF
    xor a
    ldh [rIF], a

    ; Enable interrupts
    ei

    ; Wait HBlank STAT interrupt
    halt
    nop

    ; Wait VBlank for restore OAM data
    WaitVBlank

    ; Restore original OAM data
    Memcpy $fe00, OamData, OamDataEnd - OamData

    jp Loop

OamData:
db $14, 10, $01, $00
db $14, 22, $01, $00
db $14, 34, $01, $00
db $14, 46, $01, $00
db $14, 58, $01, $00
db $14, 70, $01, $00
db $14, 82, $01, $00
db $14, 94, $01, $00
OamDataEnd:

OamTileData:
db $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
db $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00, $ff, $00
OamTileDataEnd:


SECTION "STAT handler", ROM0[$48]
    ; Jump to DMA transfer routine
    jp DmaTransferRoutine
