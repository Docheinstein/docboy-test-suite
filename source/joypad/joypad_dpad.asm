INCLUDE "hardware.inc"
INCLUDE "common.inc"
INCLUDE "print.inc"

; Enable Joypad D-Pad and dump P1 register.

EntryPoint:
    ; React to D-Pad
    ld a, $20
    ldh [rP1], a

    WaitVBlank

    ld a, [rP1]
    push af

    DisablePPU
    InitPrint
    PrintString "P1: "
    pop af
    PutHex8
    EnablePPU
    halt

