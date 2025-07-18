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

MACRO TestEndCleanup
    ; Disable interrupts
    di

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

    ; Turn on PPU again
    EnablePPU
ENDM

MACRO TestPrintTilemapDumpRegistersOnInput
    WaitVBlank

    ; Turn the LCD off
    DisablePPU

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
    WaitVBlank

    ; Turn the LCD off
    DisablePPU

    ; Copy the tilemap to VRAM
	Memcpy $9000, \1, \2

    ; Turn on LCD on
    EnablePPU

    HaltForever
ENDM

TestSuccess:
    TestEndCleanup
	TestPrintTilemap TestSuccessTilemap, TestSuccessTilemapEnd - TestSuccessTilemap

TestFail:
    TestStashRegisters
    TestEndCleanup
    TestPrintTilemapDumpRegistersOnInput TestFailTilemap, TestFailTilemapEnd - TestFailTilemap

TestSuccessTilemap:
    db $00, $00, $00, $00, $00, $00, $00, $ff
    db $ff, $ff, $ff, $00, $00, $00, $00, $00
TestSuccessTilemapEnd:

TestFailTilemap:
    db $18, $18, $18, $18, $18, $18, $18, $18
    db $18, $18, $18, $18, $18, $18, $18, $18
TestFailTilemapEnd: