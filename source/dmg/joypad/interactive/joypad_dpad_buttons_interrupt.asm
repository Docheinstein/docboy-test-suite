INCLUDE "all.inc"

; Check whether Buttons are able to raise joypad interrupt while D-Pad is enabled via P1.

EntryPoint:
    DisablePPU
    InitPrint

    ; React only to dpad
    ld a, $20
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

    jp TestSuccess

TestFinish:
    ; We should not reach this point
    jp TestFail


SECTION "Joypad handler", ROM0[$60]
    jp TestFinish