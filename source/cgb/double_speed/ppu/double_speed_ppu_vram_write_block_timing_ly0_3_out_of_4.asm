INCLUDE "all.inc"

; Try to write to VRAM at various timing and see when the write succeeds or fails.

MACRO WriteToVRAM
    EnablePPU

    ; Delay
    Nops \1

    ld [hli], a

    WaitVBlank
    DisablePPU
ENDM

EntryPoint:
    DisablePPU

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

	; Switch to double speed
    stop

    ; Reset VRAM
    Memset $8000, $00, $80

    ld hl, $8000

    FOR I, 57
        WriteToVRAM (114 + I)
    ENDR

    ; Check results
    Memcpy $ce00, $8000, $80

    Memcmp $ce00, ExpectedData, ExpectedDataEnd - ExpectedData
    jp nz, TestFail

    jp TestSuccess

ExpectedData:
db $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $81, $81, $81, $81, $81, $81
db $81, $81, $81, $81, $81, $81, $81, $81
db $81, $81, $81, $81, $81, $81, $81, $81
db $81, $81, $81, $81, $81, $81, $81, $81
db $81, $81, $81, $81, $81, $81, $81, $81
db $81, $81, $81, $81, $81, $81, $81, $81
db $81, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $00, $00, $00, $00, $00, $00
ExpectedDataEnd: