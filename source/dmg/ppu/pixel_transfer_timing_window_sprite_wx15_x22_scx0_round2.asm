INCLUDE "all.inc"

; Check the duration of Pixel Transfer (Mode 3) with window enabled
; and sprites overlapping with the window.

EntryPoint:
    ; Disable PPU
    DisablePPU

    ; Copy OAM data
    Memset $fe00, $00, 160
    Memcpy $fe00, OamData, OamDataEnd - OamData

    ; Set WX
    ld a, 15
    ldh [rWX], a

    ; Set WY
    ld a, 8
    ldh [rWY], a

    ; Enable PPU with window on
    ld a, LCDCF_ON | LCDCF_BGON | LCDCF_WINON | LCDCF_WIN9C00 | LCDCF_OBJON
    ldh [rLCDC], a

    ; Wait line 7
    WaitScanline 7

    ; Go out of OAM scan
    Nops 20

    ; Reset interrupts
    xor a
    ldh [rIF], a

    ; Enable STAT interrupt
    ld a, IEF_STAT
    ldh [rIE], a

    ; Enable OAM interrupt
    ld a, STATF_MODE10
    ldh [rSTAT], a

    ; Enable OAM interrupt
    ei

    Nops 114

    jp TestFail

TestStart:
    ; Wait until end of Pixel Transfer
    Nops 56

    ldh a, [rSTAT]
    ld b, a
    ld a, $a0
    cp b

    jp nz, TestFail

    jp TestSuccess


OamData:
db 24, 22, 0, 0
OamDataEnd:

SECTION "STAT handler", ROM0[$48]
    jp TestStart

