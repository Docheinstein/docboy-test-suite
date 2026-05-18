INCLUDE "all.inc"

; Check whether Buttons are able to raise joypad interrupt while Joypad Buttons are enabled via P1.

EntryPoint:
    DisablePPU
    InitPrint

    ; Disable all
    ld a, $30
    ldh [rP1], a

    ; Human or simulation is supposed to press a button here
    PrintString "Press A..."

    ; Hook for input
    ld b, b

    EnablePPU

    ; Wait approximately 2 seconds
REPT 120
    Wait 114 * 154
ENDR

    ; Enable Buttons
    ld a, $10
    ldh [rP1], a

    ldh a, [rP1]
    ldh a, [rP1]
    ldh a, [rP1]
    ldh a, [rP1]
    ldh a, [rP1]
    ldh a, [rP1]
    ldh a, [rP1]

    cp $de

    jp nz, TestFail

    jp TestSuccess
