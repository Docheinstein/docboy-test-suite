INCLUDE "all.inc"

; Check how STOP behaves with:
; * KEY1      : 1
; * Joypad    : not pressed
; * Interrupt : pending
; * IME       : 1

EntryPoint:
    DisablePPU
    EnablePPU

    LongWait 114 * 42

    ; Prepare speed switch
    ld a, $01
    ldh [rKEY1], a

    ; Enable timer at 262KHZ Hz
    ld a, TACF_START | TACF_262KHZ
    ldh [rTAC], a

    ; Reset TIMA
    ld a, $00
    ldh [rTIMA], a

    ; Reset DIV
    xor a
    ldh [rDIV], a

    ; Wait a bit so that TIMA can overflow and increase DIV
    LongWait 1024

    ; Manually set Serial interrupt flag.
    ld a, IEF_TIMER
    ldh [rIF], a
    ldh [rIE], a

    ; React to D-Pad
    ld a, $20
    ldh [rP1], a

    xor a
    ld b, a
    ld c, a

    ei
    db $10 ; STOP -> should work
    inc b
    inc c

    jp TestFail

TestContinue:
    Nops 53

    ldh a, [rDIV]
    cp $00

    jp nz, TestFail
    jp TestSuccess

SECTION "Timer handler", ROM0[$50]
    jp TestContinue
