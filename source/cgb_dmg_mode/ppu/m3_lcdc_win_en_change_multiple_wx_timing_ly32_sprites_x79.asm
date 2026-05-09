INCLUDE "all.inc"

; Change LCDC BG tile data during pixel transfer with sprites at various X and check for CGB BG/WIN tile data change glitch.

EntryPoint:
    DisablePPU

    ; Set SCX=0
    ld a, $00
    ldh [rSCX], a

    ; Enable STAT (HBlank) interrupt
    ld a, IEF_STAT
    ldh [rIE], a

    ld a, STATF_MODE00
    ldh [rSTAT], a

    ld a, $e4
    ldh [rOBP0], a

    ld a, $e4
    ldh [rBGP], a

    ; Reset OAM
    Memset $fe00, $00, 160
    Memcpy $fe00, OamData, OamDataEnd - OamData

    ; Reset VRAM
    Memset $9800, $00, $800

    Memset $9C00, $01, $800

    ld b, $e1 | LCDCF_OBJON

    ld c, b
    res 5, c

    ld d, 0

    ; load hl with address of LCDC register
    ld hl, rLCDC

    ; set initial value
    ld [hl], b

    Wait 32 * 114

    xor a
    ldh [rIF], a

    ei

    ldh a, [rLY]
    ldh [rWX], a

REPT 10
    nop
ENDR

    ; set the new value: 8 cycles
    ld [hl], c

    ; restore old value
    ld [hl], b

    nop
    nop
    nop

    ; set the new value: 8 cycles
    ld [hl], c

    ; restore old value
    ld [hl], b

    xor a

REPT 200
    inc a
ENDR

    jp TestFail

HandleStatInterrupt:
    cp $20
    jp nz, TestFail
    jp TestSuccess

OamData:
    db 48, 79, $00, $00
OamDataEnd:

SECTION "STAT handler", ROM0[$48]
    jp HandleStatInterrupt

