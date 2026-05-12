INCLUDE "all.inc"

; Keep a button pressed for a while and see how many triggers are raised in the meantime.

EntryPoint:
    DisablePPU
    InitPrint

    ; React only to button
    ld a, $10
    ldh [rP1], a

    ; Reset DIV
    ldh [rDIV], a

    ; Enable timer at 4k Hz
    ld a, TACF_START | TACF_4KHZ
    ldh [rTAC], a

    ; Set TMA
    ld a, $00
    ldh [rTMA], a

    ; Set TIMA
    ld a, $00
    ldh [rTIMA], a

    xor a
    ldh [rIF], a

    ; Enable TIMER interrupt
    ; Enable Joypad interrupt
    ld a, IEF_HILO | IEF_TIMER
    ldh [rIE], a

    ei

    PrintString "Keep A pressed"

    ld b, 0
    ld c, 0
    ld d, 0

    ; Hook for input
    ld b, b

    EnablePPU

    halt

    ; We should not reach this point
    jp TestFail

ButtonPressed:
    ; New trigger of joypad interrupt
    inc bc

Continue:
    xor a
    ldh [rIF], a

    ei

    halt

    ; We should not reach this point
    jp TestFail

TimerTick:
    inc d
    ld a, d

    ; Wait some time before end test
    cp $20
    jp nz, Continue

TestEnd:
    ; We expect only one joypad trigger at this point
    ld a, b
    cp $00

    jp nz, TestFail

    ld a, c
    cp $01

    jp nz, TestFail

    jp TestSuccess

SECTION "Timer handler", ROM0[$50]
    pop hl ; avoid stack overflow
    jp TimerTick

SECTION "Joypad handler", ROM0[$60]
    pop hl ; avoid stack overflow
    jp ButtonPressed