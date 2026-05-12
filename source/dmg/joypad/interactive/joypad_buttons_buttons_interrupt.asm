INCLUDE "all.inc"

; Check whether Buttons are able to raise joypad interrupt while Joypad Buttons are enabled via P1.

EntryPoint:
    DisablePPU
    InitPrint

    ; React only to Buttons
    ld a, $10
    ldh [rP1], a

    ; Enable joypad interrupt
    xor a
    ldh [rIF], a

    ld a, IEF_HILO
    ldh [rIE], a

    ei

    ; Human or simulation is supposed to press a button here
    PrintString "Press A..."

    ; Hook for input
    ld b, b

    EnablePPU

    ; Wait approximately 2 seconds
REPT 120
    Wait 114 * 154
ENDR

    ; We should not reach this point
    jp TestFail

TestFinish:
    jp TestSuccess


SECTION "Joypad handler", ROM0[$60]
    jp TestFinish