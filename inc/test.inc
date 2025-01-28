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
    TestEndCleanup
    TestPrintTilemap TestFailTilemap, TestFailTilemapEnd - TestFailTilemap

TestSuccessTilemap:
    db $00, $00, $00, $00, $00, $00, $00, $ff
    db $ff, $ff, $ff, $00, $00, $00, $00, $00
TestSuccessTilemapEnd:

TestFailTilemap:
    db $18, $18, $18, $18, $18, $18, $18, $18
    db $18, $18, $18, $18, $18, $18, $18, $18
TestFailTilemapEnd: