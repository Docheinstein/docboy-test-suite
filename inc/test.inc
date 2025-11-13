IF !DEF(TEST_INC)
DEF TEST_INC EQU 1

include "apu.inc"
include "ppu.inc"
include "memory.inc"
include "debug.inc"
include "halt.inc"

MACRO TestStashRegisters
    push af
    push bc
    push de
    push hl
ENDM

MACRO TestUnstashRegisters
    pop hl
    pop de
    pop bc
    pop af
ENDM

MACRO TestPrepareEnd
    ; Turn off PPU
    DisablePPU

    ; Set BG palette
    IF CGB
        SetDefaultBGP
    ELSE
        ld a, $fc
        ldh [rBGP], a
    ENDC

    ; Reset VRAM
    Memset $8000, $00, $2000

    ; (CGB Only): Use VRAM Bank 0
    IF CGB
        xor a
        ldh [rVBK], a

        ; Reset VRAM
        Memset $8000, $00, $2000
    ENDC
ENDM

MACRO TestPrintTilemapDumpRegistersOnInput
    ; Copy the tilemap to VRAM
	Memcpy $9000, \1, \2

    ; Turn on LCD on
    EnablePPU

    ; Enable input
    ld a, $00
    ldh [rP1], a

    ; Busy wait for input
.loop:
    ldh a, [rP1]
    and $0f
    cp $0f
    jp z, .loop

    ; Dump registers as cached after the failure
    TestUnstashRegisters
    DumpRegisters
ENDM

; Args:
; \1: tilemap start
; \2: tilemap end
MACRO TestPrintTilemap
    ; Copy the tilemap to VRAM
	Memcpy $9000, \1, \2

    ; Turn on LCD on
    EnablePPU

    HaltForever
ENDM

TestSuccess:
    ; Disable interrupts
    di

    ; Set special value in memory for fast test check ($01)
    ld hl, $fff0
    ld [hl], $01

    ; Print success screen
    TestPrepareEnd
	TestPrintTilemap TestSuccessTilemap, TestSuccessTilemapEnd - TestSuccessTilemap

TestFailBeep:
	Beep

TestFail:
    ; Disable interrupts
    di

    ; Cache current registers
    TestStashRegisters

    ; Set special value in memory for fast test check ($02)
    ld hl, $fff0
    ld [hl], $02

    ; Print fail screen
    TestPrepareEnd
    TestPrintTilemapDumpRegistersOnInput TestFailTilemap, TestFailTilemapEnd - TestFailTilemap

TestSuccessTilemap:
    db $00, $00, $00, $00, $00, $00, $00, $ff
    db $ff, $ff, $ff, $00, $00, $00, $00, $00
TestSuccessTilemapEnd:

TestFailTilemap:
    db $18, $18, $18, $18, $18, $18, $18, $18
    db $18, $18, $18, $18, $18, $18, $18, $18
TestFailTilemapEnd:

ENDC