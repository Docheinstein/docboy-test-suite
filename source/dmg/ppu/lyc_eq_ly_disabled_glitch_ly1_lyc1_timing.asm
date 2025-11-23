INCLUDE "all.inc"

; Check LYC_EQ_LY STAT flag at various timings.

MACRO ReadSTAT
    EnablePPU

    ; Skip first scanline, just in case
    Nops 114

    ; Delay
    Nops \1

    ld a, [rSTAT]
    and STATF_LYCF
    ld [hli], a

    WaitVBlank
    DisablePPU
ENDM

EntryPoint:
    DisablePPU

    ; Enable LYC_EQ_LY interrupt for LY = $10
    ld a, STATF_LYC
    ldh [rSTAT], a

    ; Write LYC=01
    ld a, $01
    ldh [rLYC], a

    Memset $ce00, $00, $80

    ld hl, $ce00

    FOR I, 114
        ReadSTAT I
    ENDR

    ; Check results
    Memcmp $ce00, ExpectedData, ExpectedDataEnd - ExpectedData
    jp nz, TestFail

    jp TestSuccess

ExpectedData:
db $04, $04, $04, $04, $04, $04, $04, $04
db $04, $04, $04, $04, $04, $04, $04, $04
db $04, $04, $04, $04, $04, $04, $04, $04
db $04, $04, $04, $04, $04, $04, $04, $04
db $04, $04, $04, $04, $04, $04, $04, $04
db $04, $04, $04, $04, $04, $04, $04, $04
db $04, $04, $04, $04, $04, $04, $04, $04
db $04, $04, $04, $04, $04, $04, $04, $04
db $04, $04, $04, $04, $04, $04, $04, $04
db $04, $04, $04, $04, $04, $04, $04, $04
db $04, $04, $04, $04, $04, $04, $04, $04
db $04, $04, $04, $04, $04, $04, $04, $04
db $04, $04, $04, $04, $04, $04, $04, $04
db $04, $04, $04, $04, $04, $00, $00, $00
db $00, $00, $00, $00, $00, $00, $00, $00
db $00, $00, $00, $00, $00, $00, $00, $00
ExpectedDataEnd:
