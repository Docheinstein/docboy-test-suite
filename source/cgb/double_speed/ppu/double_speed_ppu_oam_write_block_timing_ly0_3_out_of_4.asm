INCLUDE "all.inc"

; Try to write to OAM at various timing and see when the write succeeds or fails.

MACRO WriteToOAM
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

    ; Reset OAM
    Memset $fe00, $00, 160

    ld hl, $fe00

    FOR I, 57
        WriteToOAM (114 + I)
    ENDR

    ; Check results
    Memcpy $ce00, $fe00, $80

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
