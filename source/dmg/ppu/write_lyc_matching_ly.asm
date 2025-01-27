INCLUDE "docboy.inc"

; Writing to LYC the same value of the current LY should both
; set STAT's LYC_EQ_LY and raise the interrupt.

EntryPoint:
    ; Reset IF
    xor a
    ldh [rIF], a

    ; Enable LYC_EQ_LY interrupt
    ld a, STATF_LYC
    ldh [rSTAT], a

    WaitScanline 2

    ; Read from STAT before set LYC
    ldh a, [rSTAT]
    ld b, a

    ; Write to LYC
    ld a, $02
    ldh [rLYC], a

    ; Read from STAT after set LYC
    ldh a, [rSTAT]
    ld c, a

    ; Read IF
    ldh a, [rIF]
    ld d, a

    ; Check results

    ; STAT before set LYC
    ld a, $c2
    cp b
    jp nz, TestFail

    ; STAT after set LYC
    ld a, $c7
    cp c
    jp nz, TestFail

    ; IF after set LYC
    ld a, $e2
    cp d
    jp nz, TestFail

    jp TestSuccess
