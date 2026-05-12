INCLUDE "all.inc"

; Check whether buttons are able to raise joypad interrupt when released while Joypad Buttons are enabled via P1.

EntryPoint:
    DisablePPU
    InitPrint

    ; React only to button
    ld a, $10
    ldh [rP1], a

    ; Human or simulation is supposed to press a button here and keep it pressed
    PrintString "Keep A pressed..."

    ; Hook for input
    ld b, b

    EnablePPU

    ; Wait approximately 2 seconds
REPT 120
    Wait 114 * 154
ENDR

    ; Enable joypad interrupt
    xor a
    ldh [rIF], a

    ld a, IEF_HILO
    ldh [rIE], a

    ei

    DisablePPU

    PrintString "Release the button"

    ; Hook for input
    ld c, c

    EnablePPU

    ; Wait approximately 2 seconds to leave some time either to humans or tests
REPT 120
    Wait 114 * 154
ENDR

    ; We should not reach this point
    jp TestFail

TestFinish:
    jp TestSuccess


SECTION "Joypad handler", ROM0[$60]
    jp TestFinish