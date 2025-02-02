INCLUDE "all.inc"

; Check that CPU goes at double speed in double speed mode.

EntryPoint:
    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a
    ldh a, [rKEY1]

    ; Change speed
    stop

    ; Reset PPU
    DisablePPU
    EnablePPU

    ; Enable LYC_EQ_LY interrupt for LY = $10
    ld a, STATF_LYC
    ldh [rSTAT], a

    ld a, $10
    ldh [rLYC], a

    ; Reset interrupts
    xor a
    ldh [rIF], a

    ; Enable STAT interrupt
    ld a, IEF_STAT
    ldh [rIE], a

    ei

    ld bc, $00

REPT 2000
    inc bc
ENDR

    ; We should not reach this point
    jp TestFail

TestContinue:
    ; Read DIV
    ld a, b
    cp $07
    jp nz, TestFail

    ld a, c
    cp $14
    jp nz, TestFail

    jp TestSuccess


SECTION "STAT handler", ROM0[$48]
    jp TestContinue