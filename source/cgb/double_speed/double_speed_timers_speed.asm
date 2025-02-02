INCLUDE "all.inc"

; Check that timers go at double speed in double speed mode.

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

    ; Reset DIV
    xor a
    ldh [rDIV], a

    ; Reset TIMA
    ldh [rTIMA], a

    ; Enable timer at 262KHZ Hz
    ld a, TACF_START | TACF_262KHZ
    ldh [rTAC], a

    ; Reset interrupts
    xor a
    ldh [rIF], a

    ; Enable VBLANK interrupt
    ld a, IEF_VBLANK
    ldh [rIE], a

    ei

    halt
    nop

    ; We should not reach this point
    jp TestFail

TestContinue:
    ; Read DIV
    ldh a, [rDIV]
    cp $01

    jp nz, TestFail
    jp TestSuccess


SECTION "VBlank handler", ROM0[$40]
    jp TestContinue